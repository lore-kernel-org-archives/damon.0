Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8F47ECFA;
	Wed, 29 Jul 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336467; cv=none; b=Fkq1iUyuXFjiZAZjBvdbkxlnfTIZU+2wiek601abaAzTx3RqBTv8jSVpC6LZI47DOppnr0LGfLuygCXKNgn8/nJhRbFPIvQzjmMKxgjvnH+JEosWbN4hTh4+1TXsPeLiyjocr/poXacGdLPtbEihRIOMc6XMstUdNotZJgVQsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336467; c=relaxed/simple;
	bh=DJPYvh3BoeDGZsI6ipGISBHF/SQmPmzJIQyhoWHeFFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNAdq4H30V/WljV/1ccTSQAGtc3vfkd/UIs9hKqXNmqBeJCcgj+n6B+kJPprCThMXDHj1aPPhQDU478TCLeNqg7LVLY92Pq5V7MCxR901WG3PVSpnyQz/bQ8phZUGOc3A1fSZjZ3+R6yki7CouhnBpGiKj57hB4tv9giAa9N7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKYKFRM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKYKFRM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B20A1F00ADB;
	Wed, 29 Jul 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336464;
	bh=MtDpGEkDh7eFQBN1dloGGbcdOXn6qckrmCm8+BjUBow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKYKFRM1R/OCPGoBU0BaoGq5cV55Eouhc7kW5fvTzrjoeWnw8oGVfX+lv7uNM0mZx
	 myBMSUGwVzIeXaC/JNHrEzKyxK4zU7SX7y9ZIY+Qnc+pl705brcx9LdRU7kuim0A+9
	 MKvsuXs/1j1DkoIEkuIUYjhgTVxQAhFmxTziyPxA374uAbpu8v+89AD5XP7zOrz+Hi
	 z9OaJle3nahczWGdsxGqfpB84eqEvkXd3XCCKEQwzZu9fB8xWH4hRvMsK2FmYUa2Ne
	 DDh1AQP6GTWFWRWXeUN/fDrC6VKMwoXjYLd2Lvd7ilJBNNkb9N6jZ4ka0mwSelx9a+
	 E/Ev/kw7oFB0Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/6] selftests/damon/drgn_dump_damon_status: dump probes
Date: Wed, 29 Jul 2026 07:47:35 -0700
Message-ID: <20260729144738.90895-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729144738.90895-1-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend drgn_dump_damon_status.py to dump damon_ctx->probes.  It will be
used to see if in-kernel DAMON status are changed as the user sets the
probes via sysfs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 .../selftests/damon/drgn_dump_damon_status.py | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 09552e91bc782..4622046fd0118 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -48,6 +48,37 @@ def attrs_to_dict(attrs):
         ['max_nr_regions', int],
         ])
 
+def filter_to_dict(damon_filter):
+    filter_type_keyword = {
+            0: 'anon',
+            1: 'memcg',
+            }
+    dict_ = {
+            'type': filter_type_keyword[int(damon_filter.type)],
+            'matching': bool(damon_filter.matching),
+            'allow': bool(damon_filter.allow),
+            }
+    type_ = dict_['type']
+    if type_ == 'memcg':
+        dict_['memcg_id'] = int(damon_filter.memcg_id)
+    return dict_
+
+def filters_to_list(filters):
+    return [filter_to_dict(f)
+            for f in list_for_each_entry(
+                'struct damon_filter', filters.address_of_(), 'list')]
+
+def probe_to_dict(probe):
+    return to_dict(probe, [
+        ['weight', int],
+        ['filters', filters_to_list],
+        ])
+
+def probes_to_list(probes):
+    return [probe_to_dict(p)
+            for p in list_for_each_entry(
+                'struct damon_probe', probes.address_of_(), 'list')]
+
 def addr_range_to_dict(addr_range):
     return to_dict(addr_range, [
         ['start', int],
@@ -199,6 +230,7 @@ def damon_ctx_to_dict(ctx):
     return to_dict(ctx, [
         ['ops', ops_to_dict],
         ['attrs', attrs_to_dict],
+        ['probes', probes_to_list],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
         ['pause', bool],
-- 
2.47.3
