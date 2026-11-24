Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534617;
	b=O7vBTw/viNGAqV8MFZg2gDM6nFyx+odI+6/oAORbbAVReFrut7kDZi88GlX/OxDKENhe
	 1RjIzOf9H3OjrMMNfmA3uitx1RHuEHbTZciuorW1UozIKBMxf0zZgMcYEusi7RwvvOS+D
	 6ShnvFD/Ylhpdf0fRTnr1Xl9YhGqN0T/kESuiOOueGa36NXS/9oD3+6iDTb8jISMMFNjh
	 SpdaM5OP9T3bNm8bVVzl05ivOOr9FS580idMxnQHlyiBCtltdbeqFVr6Gvfuz3EJKynGH
	 Q3iN4QiF3y21W1K20fiKEsm6pWhLsZTVylUcpNy/mkjJQQthnyRGH0CXJ1sPTav8AhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fFI2hTCt5eZqUcEvGUUP+BnRCJkTFjEHVXvNBQkTSvg=;
	b=4AAa1cVaglENreYbc6Nac+rXr7C+ZHEYE9BSu/4GXiKjuuaI+Zxh4/nhGms4nfgCOL4p
	 FWFTObFy1w4bpZtW6CzF8tczbnYmCemOj8owThbSZjKuFPPx8oRsRgzO/0L0+sVD2Tnh1
	 T3+71BWhy1QVXLrmL3JG7xdaatoy0SjpEyeu5hEJ4xXmdA0G7lm4oGV3AIEhSyvcuNAjg
	 8SEz51EfIG/w6Dmr3vcEPZo+UT0R7gKsyruNx1Bbgqq8q52bwZnCowMYRau1OLQP9tfWs
	 gRqTgWBf3wFC8KqiZ+lFX6546Yw6netVSDtRqUJ6kJlfaykTEr+EwaghXlenEINj37w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izkxTDgs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D4606A31E;
	Tue, 24 Nov 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izkxTDgs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA031F000C0;
	Tue, 24 Nov 2026 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534617;
	bh=fFI2hTCt5eZqUcEvGUUP+BnRCJkTFjEHVXvNBQkTSvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izkxTDgsHqwmqUsLQu8COBMKwWTfCc4vDwPvz8bIPqjDL7VfKVoImPRHVhNXNzX0a
	 /fQoLd7/vqKOPiiaCTMbG3l978x2jqmAF1Mjs8W6KcLIrxzg+376v3SsHgsKd8O+Lx
	 TwZFpYwBTZNSN6daLrh35F9qoP4qzl5HoERaspOLxiwr9sX0isxLQtHJVfX2cYlvMO
	 tmIKmkNVw7BVyD7QhyFuAsgJdbjBRRtSB5jwK8juLCPKf/8TmNocHD6p5RUI6Mlo6p
	 d5B3ut2Aaq2HrkJFCr7Px99bjvWmzfMdeF8CI2SifWjTKQU1bULmQ37Gzx51AtdtrA
	 9eQflmZcIRduA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 17/27] Docs/mm/damon/design: update for report_made probe filter type
Date: Tue, 24 Nov 2026 07:36:23 -0800
Message-ID: <20261124153636.91854-18-sj@kernel.org>
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

Update DAMON design document for the newly added data attribute report
existence type probe filter.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 59dba2fe0dfbf..7ead5716d0c30 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -303,6 +303,8 @@ supported filter types.  Currently below filter types are supported.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
 - ``active``: Same as that for DAMOS filters.
+- ``report_made``: Matches if a :ref:`report <damon_design_attr_reporting>` for
+  the memory is made in last sampling interval.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -382,6 +384,10 @@ depending on the type of the report.
 
 For now, no report type is supported.
 
+The data attribute probe supports the reports.  The probes can be configured to
+hit for a given memory region if a specific type of valid reports that are
+associated with the probing memory exist in the reports queue.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
