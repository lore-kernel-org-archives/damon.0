Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FD37EFF1
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267438; cv=none; b=r+T8QUzkqygdPeoFlt0yg1wpq4LpqGuyRgEH9U9a6k4IN/lorcVJGyDv8h/QT3cIDo/FSoqNC/3yPDeoFVeTIXqMSy3QC3iAMc3rgBPFHmHQomQ0kN0j5fPAJUT+UFckKkvU5auGu1WF7tXoaI7iq8Osk1jDlHbs2NgkyCrl24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267438; c=relaxed/simple;
	bh=IZIiJRLdf7Y62rMyh6mxf3vTvBb0tPVfGN3EcD+VMpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbHmhfu1DjRVAG3UrEzfWSXalk2L4odjEjniPKrElD0/uBi2ldOb4Z3/XQwm5vrVXI3DpGVh/4g7oReQgA0mx5pyf0CFZ8B6puc64Gf6ieB8z1knvj1bxUB91DXXB5orKugmJdcCuDUi+xsKbu3ZIq5Qp6DTiVakcZSW6c9Fxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4dpN6Ux; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4dpN6Ux"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so132556a91.0
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791267433; x=1791872233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XGWdEYbUJd8tcJmO7sHix7Djo1stlaazK2dWhUeaRg=;
        b=I4dpN6UxZ7TyrkFyuej7D5TAIU2lYFRMygmBRJc2FnOMTAOCVkhlaonzlwUxTGW11N
         hdQU9hOp69YExcLHKFss9lYUvZDLt/vipfFR5G4ba1/fcpifb15Wxhvy7Cd3zd5V7xf5
         weKf+QlPf5FBvaLzQsxFaeoGogGZ6N71f1vciP4VmOs3QdqoHYl+J9PQ3YGRtQk1tnF5
         3Nioa2R39UFKxj/hywG/rU/JhuXkx8GdOUJuG2MnsFT09uR+4IBf27JlVMSl7w4aEa+3
         VrLmOglw3wsUj7udneo9oEvouu6EicQL8fTbx2PKR9/ZTtMTVD64NF4avJES0KVzDAAw
         v2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267433; x=1791872233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XGWdEYbUJd8tcJmO7sHix7Djo1stlaazK2dWhUeaRg=;
        b=ePNpVK3psAaTGKPVYsc+BZ70zpYya8pJLUtYHx2JAWm8LmpzIb115ck0F7YH82f8GM
         neIUG+v4TetUdZLoJ7kQ/fnqqfPGrBMdRBvSnxGTgB9M5JIOkz4BHvsGcwC2iwvudZbi
         dIU6hkrKyeD0e3+o5KOBVcOnMw56iVKlBUl3V2iTGw0UAjwt2wW74qLcHeWznYIy+e8V
         /3U67eAK1ZuFzZ7lWtGfizyl3CN8BPWvYI65Z9d68bhCNrARXfES14ZwGWZ44ftDry9x
         ulEnBEGzt3dWULQDqGpifQkxh+OYFgYM/WvLxGjGCdWkHPV1LZVdcD4MWdFvjGY6xMSB
         Nm/w==
X-Gm-Message-State: AFq9FYLXkt5F1Sh1UI06jPQdiAaSqGPHpbjCjvnOscjhjiv33Tp93izs
	KKiSGQRkCxmOueVe+K2+MZ89w7c2AOd8kz+t6+HbIvcQpV/C+QwVOapW
X-Gm-Gg: AYBFou0SNSgUUyyvKh6vbV/LCakPQmGhuOhVJDE3Xb6NHJRhpaz7pEd/+bx15UkyxOl
	qAq5AFAY5KalgooWq6T4HoC378bDdlaXx1RlocqqZQYDKcx5bWa5CQkx6emDdA6AwQ7TeofH3iJ
	p/CsB/cxLx6msIcKa6jDUkMPpxUdKIeVbG0LcnGl2DnS4F5wXxFdWx1rlw+7gvKtLGe+/GMUwKi
	2vY7D45Qtw0jTrgqZ0YtYSLRJppGE/yALup8bASEG8hET9sh6h6clUIP0bUaa5lLi686cDSMIZE
	BuTAh57MaZ7nQY6/lhKcTzeF+ST2HZ/ob36BMumxPkWfdfCkcB9gF7TnqsLv50uIXR0UeiOR39b
	L3lzfiuCO2Wnj+/M87iC5y+o2UIpx8DCvzcvnO7/LJDYLj8Fs6LWN55ynAWxFErYDQSXPhhh2mu
	NCD3uNfVUQHKnUPA1OIk5BFiWbCmH50iVW7GnuzUKw95NZFkHUYp8z94AxUwe4hN/2syCJvWh8Q
	4juA2hAUV65a6TgfPM88rV0wmeFcc45VdrG1eKkWoHVH2msxI3H6Uf2JZQ5z3kCfvURPODZ+ZTg
	mXd7oibvn4pvtgs1isQ2+A9VtOc=
X-Received: by 2002:a17:90b:2e49:b0:3a0:c3d4:f3b2 with SMTP id 98e67ed59e1d1-3a873729daemr295202a91.56.1791267433227;
        Mon, 05 Oct 2026 23:17:13 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm3662789a91.2.2026.10.05.23.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:17:12 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 3/3] Docs/admin-guide/mm/damon/usage: Fix incorrect option syntax in perf example
Date: Tue,  6 Oct 2026 14:15:49 +0800
Message-Id: <20261006061549.627-4-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006061549.627-1-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kill command in the DAMON documentation uses an incorrect
option syntax in the perf example.

Use kill -9 instead of kill 9 to correctly send SIGKILL to
the perf process.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 3d43954c7046..bd687d89ea4c 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -749,7 +749,7 @@ show results using tracepoint supporting tools like ``perf``.  For example::
     # echo on > kdamonds/0/state
     # perf record -e damon:damon_aggregated &
     # sleep 5
-    # kill 9 $(pidof perf)
+    # kill -9 $(pidof perf)
     # echo off > kdamonds/0/state
     # perf script
     kdamond.0 46568 [027] 79357.842179: damon:damon_aggregated: target_id=0 nr_regions=11 122509119488-135708762112: 0 864
-- 
2.43.0

