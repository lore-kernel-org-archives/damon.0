Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8533E0251;
	Tue, 30 Jun 2026 04:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792511; cv=none; b=OSIn5F4MVGbKjFVFkyc21e5b8ed9EbDKNZL8PNgL7yjfOY5w8/t27ctdwWVQoZqqMEPJz76/Z15cuSOs6FcKGc04ZE6MeDbq3h162aym4oYDNRAqBXxMa8NkfkFk/Qm1Mnp8waAOzSYTyw4K3xrGfzyt81BQZmFlT0mXfiYC+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792511; c=relaxed/simple;
	bh=ewKdy1efkDdYu4TOEmkfDQj6RdXnRvHlsS4CuZm3njM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQI9/dctQiIhVLQ4X7K9qpXBvEQgfiac5LfTbmLHy729H1hmuusqEfgN627PuujO58ApDaZKE7IRIcK6KYSyQjmEgq2xjQ57jAaIZyrEwRDt1eAmAm93Kxir4BCOmYdZjnNhQYbWwPQqdAEiUburXZHXQjQNmSph+r/2vXE+mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc7YelDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc7YelDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BDA1F00A3E;
	Tue, 30 Jun 2026 04:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792509;
	bh=skYRzDOS/foSXvMB2iD1p2qAPqi0rQnLSDGnJ62RQnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dc7YelDdA6DB63nkfnz7k8p0edIKaHqIlj53qT4gEzVtO+rbRBUrMI8rsysDHpjve
	 G3r34GU1jSeUpNC/gd+t6fuSjnToMBoVCS7CD+QzgZHCAHWXRN7cRBxrIDwssbHkeU
	 S/XiPHXppFVamRggngbQv0dJGBnB/tGuEKyLgJtH3sXRnfCs4eBSNbuY+NlzkmxkK2
	 nZVsGU89NxoOwbFysBiyXsZ4AUz1GJOSM5NNSJ7mIvDekvOFTuY9/nZ/QpSzjEDF27
	 N+kHG4hOaOqVGD6b2rAqc2TDGDVKgEC4YipicJMw4a3aNM8EPyymK+7Tc26QH+SDQV
	 sYMkn2INmSsvg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/18] selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
Date: Mon, 29 Jun 2026 21:08:05 -0700
Message-ID: <20260630040812.149729-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is dumping nr_accesses_bp field for future use
case.  nr_accesses_bp is not being used for a real purpose, though.
Hence there will be no future test for it.  Do not dump it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 26b207e44268d..09552e91bc782 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -59,7 +59,6 @@ def region_to_dict(region):
         ['ar', addr_range_to_dict],
         ['sampling_addr', int],
         ['nr_accesses', int],
-        ['nr_accesses_bp', int],
         ['age', int],
         ])
 
-- 
2.47.3
