Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014012;
	b=FhxeSg/O+tKLSUtuMchfng5UpcCoUQPQUkylbVLUbmoB41NNjDxnjqKplS23mAj/Hnkn
	 0p0tNxno5PgszwXweosCwy8+gmexixrUUc/r2P2wicfw9WSNGU8M5pm//hZN8QsrVntC5
	 lArvsc6MVVSKxLHdLDvnv+uLZkVNI0i1sVFGh2Xi8j+0rSP6wlf+TtmM3KW6sfNQt6IXw
	 2v7YTp8xRWAAqUlHKG0xkskOo51KmxV0JEPjcTJzRdBYQT2wpnfcWDzgIIcXSFYzOUCrd
	 WWw94o+BM6FBGAqXwkVRsQKZGqXwcdq4dkIg7IokOTbwnVgVIUbRjXrOxtOC2KQ6GxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=sEilWQt6Xf8SeL6f3xmlWFKcnQWSknDf8DdIPF1cvBk=;
	b=e6UF1wfKfvXK91Wc3ALn7svjgswriv0spN7AiwvhDxdjDaC2Ul4qbJABleugrZ1BuR8T
	 0FFpu9QisaFSYZ5fxhmv2ENWVodPUw5RS47y2tkOzdzJaSkjzeAq5QPQ+H9j9nsizdgde
	 h/yBm0FwLUGJ+0xvllBGA8MselWo/s611ypbixKTh2o/340K+zi6OH/MH5KMtKa6abFJN
	 CxM/QqtIg/z+792GSaXkF6wTADnclHFfim7O2/D7NKFCJUpSIU5/17K8Tu8ZyGRaDYuHF
	 VC3Nf9xG1smnBtXSp2uzfeflBF1czSm0tQMKUNN4hm/WPDC4edfgVx+O//cMRdrJ6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VPBLL2hO;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AC606A31B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VPBLL2hO
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada2f39f30so761467a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793014012; x=1793618812; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sEilWQt6Xf8SeL6f3xmlWFKcnQWSknDf8DdIPF1cvBk=;
        b=VPBLL2hOt2YbbvYO9G1me1+0q1GnhTbYp34fT6HHAvunFIkulvZ0qygnAS48j2QVJE
         mkJA17iMc8YtVkMYhJ09ph7kPblKunPd/AdOAXBVfUzSVPa5OQ2xKbPtfk1eFQ4n09Wv
         es1R5/bJE7dMQZvKxwengbb+WdifDTMnA6YlZpYmKiK7qa4GF5O/Xc+3Mu21mPwp9VTD
         KMt+OSq4UHZ7/nP2iG+ZC/KGyl3xtNJeCIK1g7sSPEAVnFZ4j93OZbIHigTK5LbJc4o9
         BOJBcDfU2gre175MtpyG1flaPfpqFBdVzvJxFA6GJB1wYvnixxZ49B08Hof7wFKdSrte
         Ds6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014012; x=1793618812;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEilWQt6Xf8SeL6f3xmlWFKcnQWSknDf8DdIPF1cvBk=;
        b=sTRAH0hXtx4Lm0iWUG5KHsEQ+UQIXagdkbxsyE/GqJaoR1IDBiiKNMaXycKSikB/vO
         jpeX3tBfkbZrGngUyzDSdkom08ohkdI52F7Mic8lOGPPtnfo+c9OThM0Souacsz9ob4i
         8gTIH/AwhFn89aFjyQtFueyRGtVpACiIFuUXWmHypkbhGnbn5pihvxRZXMa130ogCciD
         y4iqueVUywkB5f3BHMpzvt665kEjEHc5nFBAzMhLddNriiSBG/EoG1V5bQHCQTNVFpAM
         CA7W2+jNk/AUR9nnTr3FXBAn39Ka4O8f+l0IJvSG8oMytb2Ljd7Uy9XPdaiiBrTNHYDO
         WROw==
X-Forwarded-Encrypted: i=1; AKwUvBwvPptB7ToHk2IJlPXBdXsulZ3x6aqaoIABIc6r7Zb2VPKKiTmZwVOowRn0kR+mIypXJNtbXQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKP6FJ9Q3rurExCHq4twF/S7W/qf7Zv42LbuZFDeagm6bY0cNEk
	FtNTAOt0ymNLVUVxCSs0d4KATNgKPFZV2QdpSxNb19loSGRyalvG8ih7
X-Gm-Gg: AYBFou19lep9iCk8sh71bKjP4xzg32yQy9YvpRcR8twCBKYFib7rJtlGVW2x6AO27yy
	1OIC5GFB0KU142XdvSO3qOMjdwazUvY2vNg5HlzLlUrf3i5vPgYXKcfw2dk872mC2hKPTShEFsM
	gAJEDsrEgQ3MD50E4wG0iYdJFeBISN5K5FHqFhcWJ+qX745qNtrMMeagyJDxz/lhuN2tiJhkjK+
	7NiA2i19+GmXMVEAb4AG4/BK4Yxw14yHGUGQc4JFWIXnR0qgc3r1gmZpCR8S7hfLfl7+WS4WTae
	0hccHW4yLFFcgWDfJTF/19Z/wL2bLSSjfwIk1DLxOfSEDeYr3cLzzOaGPyih92PkHXaDW3jztTI
	C+DTJ2PYJIbOmM34qf3j0KMa69bXnQWJFoc8otk1w4TTHGHJeFVKOLbXH8Z5cW/Sxoh5OxaAE1F
	HrDT8eTpsH0avJ4pno4MsTD/4wFWwKBD1xBB9tzF9iXzmgRzrMw25KASb2gF+tmDhe1M/uYW8GD
	RCJt67XOJ+gNxbCVd0cbjH3SDU21wsU2UZx/NHrS5R7SxLT/lNUY3TywWZME7yEfGCO53EkDQiE
	xEACA51S0fXJZ7M6KLvrusZD0yUfOGkX+6otLEW88JGW0pfiw5Oj
X-Received: by 2002:a17:90b:548e:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3adeafad105mr5506790a91.52.1793014011466;
        Mon, 26 Oct 2026 04:26:51 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe9078asm7950626a91.10.2026.10.26.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:26:51 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] Docs/mm/damon/maintainer-profile: fix subject-verb agreement
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Oct 2026 22:14:39 +1100
Message-ID: <179301327249.2.2109326531018240569.damon-docs-grammar-7@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

"The DAMON maintainer usually work" should be "works".

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 Documentation/mm/damon/maintainer-profile.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index a7c135233937..c48269032024 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -63,7 +63,7 @@ management subsystem maintainer.
 Review cadence
 --------------
 
-The DAMON maintainer usually work in a flexible way, except early morning in PT
+The DAMON maintainer usually works in a flexible way, except early morning in PT
 (Pacific Time).  The response to patches will occasionally be slow.  Do not
 hesitate to send a ping if you have not heard back within a week of sending a
 patch.
