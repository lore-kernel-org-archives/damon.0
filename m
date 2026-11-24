Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534619;
	b=Y0JVtMm43pwOfCWh+f4DUPCUF29u3HLxLeYWzh5o0Q5dxq9O0FXe7kze3x9NJzFaZHiS
	 eIeyK8pJSWRYIgemJSTzui91Y/hmV4YfgJFLfvf66DqD1oxqCPrpBQnr08/Ekbl5nvQwj
	 YxZBlnL7hqq7Dx2JC8QdU+H1rFLINVaZgaYXF8xjkR5Cg61cva+e/wP+gqRnVt5mexHwn
	 9b0m4mr+/L5A5O+znvkXWPrjPFBEIoJucxtIgEuI+Wgre+fAvJ/lhlnC82j1d00HHeXIs
	 QgyrTKh43ibPhUIkpSicTMAGud3x5vJFwB1fptYjrYkg1QRlccIvhVL56oJ1YCNtStg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xyKk+lwXs/oM322dL7s73a7m8XTJBc6Hdzh0EajUah0=;
	b=16MXDv3Yuvf2/GBKn6LTcDme8q0FYUeZ6y8hCJVyaGYZ8VfpgwzxUGUn0LR9gg+cpRWI
	 5Uu9GJJbs8HmALYIDGIBcSuB54EHxucfAZn4qvEHuwSEpNU3ZAqCHkXQ75YscrRAJnvTe
	 5t/bcN6NcDoCxCcMNBB/duaJCQ4FEXQYX0OUKdHe28Dd4Wg8abXHF1avhyd5eynX175Ji
	 IEbe7k7ncWLNtcNPpwEHjn57315GOQcG88U44mpp2I4zYNC7BHn34QkLRaxUtWa5JvGhH
	 yP8cfQGWHS6FS88lqoyVX4kNCuNz5Hh6wI0Lc4P2VbRkKuPGicU4smFUQMRd287apLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Se4qA6/1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Se4qA6/1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C861F000CA;
	Tue, 24 Nov 2026 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534618;
	bh=xyKk+lwXs/oM322dL7s73a7m8XTJBc6Hdzh0EajUah0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Se4qA6/1wIQAd9itRWEClMIA5gqCifzwXUYzX6n8sW6lQuEyulH9abK+8aj/IWiL8
	 SoVZ7GXpmTME2hGzrCvDVw/sZKjW4EDUOd5hrNMpSxUfMe07HQ6u8FebCiRM03AMBk
	 jgi1WctP/gREyVO8KpuH6UH32vMBoA3wI07pikumvok7I3e6jCjfTTwB2JayF9Om8K
	 LVYGhX75IywdOuzVaFzumdAffWfyPJU1he8iMwUruJJVZxPa8Vo27/ewLQKV1mGink
	 AWFTOCtRyxOsgJI83E7SvAubTbGFrgk+MjqYWKmqlkYnmdS0gG4NRuY0UtAQ+TPQui
	 wVVNtR53UfySQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 19/27] Docs/ABI/damon: update for REPORT_MADE probe filter
Date: Tue, 24 Nov 2026 07:36:25 -0800
Message-ID: <20261124153636.91854-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added REPORT_MADE type probe
filter support.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b5e5004ec9fb7..692827674a773 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -233,6 +233,13 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		hitting the probe for the memory that satisfies the 'type' and
 		the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/filter_report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'report_made' is written to the 'type' file, writing to and
+		reading from this file sets and gets the 'report_type' of the
+		reports that this filter is working for.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
