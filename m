Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCB43C7B2
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443542; cv=none; b=Q20Y4IRaVP9fFdR8BcYIIE9jdMBLAKi7LEi41ci56xOok5PjS3l3vpwL82F5gqv1HUZ7g5dM3tb6mxc5iKah8j08FjI0k6d2TMinffWREpeat+YtwEgsVmpV/Q6uKzL6HoLhaueuLZL3zHzjy4GhFMrDrGWP28jAyoJnqd46/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443542; c=relaxed/simple;
	bh=Nyhh/ir10TZG50dlPu+MuFCWk/UgwhRj8pI2VXiT9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/Hsj9FZMRiO8iQuhevMwHI6eaIxm+D4+6yVLU8Yq3d3uwV2jqfokeJQn4VtyoRDaJPhEiRF5LUXcloa+Iz8ABHeaavR8tV2iq5UZp8O4ihGSL+QHLeZquxd4muiuvOu8uM172RfBk8q7S+sLGD1BnwFpJF+dYjISSczjEoSlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR+EGUzV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR+EGUzV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d0407aedd6so30924425ad.0
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443527; x=1787048327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=ZR+EGUzVNb0WHrcOX2g3xV0Rfth8ZxGN9eGKk38fS4Y6H5wzTY3yYmoKRAtWMJFVUY
         Cs4d+42Q9DPGm8xhLNZBlFaugw7ziKSffNke2arMtJJPdfcguuvdVm+ThvjJpmEOTeEu
         JXTodWONKXiOqVUab437B/sF6HYVynbSRqAtvm0lPlZmK/LFum2EcmjJVdeE05w+Js0R
         3OZeQvhNoq9V8vhV60OaEMURWirfgaR1IIro/QU6oabCCd19uVoaCCXQ0toUdNYn5x6S
         F+FxkdN2J8AOJFLFOS1dbO0Py3cH1CH8PjrBv6NHDaFqqsJyhH19V5Tu2ONDqsx5HhIh
         smuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443527; x=1787048327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxZo8B7n4c14lfP0ZG1amHyFP5yaEQUN0LvXnBt5yBg=;
        b=bsIPHMlr5jSdyQ0/LFe6i8cEi0JZt8S/KFwV6Q5pNKv7RGwZJbUtl7CfrgLJZINHdd
         k7kMOcY1cfH8KaPi5FE0Lphae+UoIGP4iD3lt0We/xFCnm2XcArW1acJi3szECqlEQ1/
         efQj0fFKqahyR1sdalAtmkIu4Ei5rp+DcVmoGRvVsITKUXrNo78MdVb6UFPJ0vQ2qBgq
         FfQO8uIGmZQHGL6Mnnvraw0XNSFzZ0N/VIMchJyePz/jws/qugaPgb3bJqrTJ3VxOFEq
         DTB/luAJ1jn3U/QlegPd/sRRI8NqBDKLQHjyL9WdVzQJ/dpOFLp+7J67DXlY3ZBTSa2f
         /yhQ==
X-Gm-Message-State: AOJu0YzlyesEpUdr+AqSx13TXJH0HolPNXC9DW3+RCopvwg1eViRrVxR
	K+GYdxTVKF9EXx+j8saHV71ScYWbXTiTzKQi61naSkaNoyW656MHfLzn
X-Gm-Gg: AR+sD13K+2S8XvDj0Uk0bBP9/a0XI/Fmd8d54H9mUzyDrQGGuJlLiZar/GhPpe3CEkJ
	aEK7in+dRJW4fy4hhSJdiWayf8oqktsu8vspxYmv2vRJNVCkm6kbDzgKjTtQP0WkXw5h40FnOap
	K0Dkk/MW05S9t2mCAAd33hbsEYzCiy1nMd0gRLX6QmmvdYlgXl+dCtRND7+QYekCLsuL+f0b+IH
	72+xj0K8PptaQYfz1sWm7/RqcdvRIL90aJNi4nGZ7Yhvvuapc/+qg6PaE0IFfNgRCQhiq50jGft
	u9eU+fCd07pI5soGwSz4/djtngYDvmHkmeuc4uSq5ArK6HIH0e+nvTnC5Dh4prFZP6wgrZWjo4y
	PSbxufgzWnboVOB/YiRSwA42swE2W6VL33qL3dLJgWFIubRU8b13JtfSPyybvQR3oICVvyJHDNY
	4aj1g9seVR/M4r4VgbRPaPt5IQIQ8aR2bybbUE9F21c40feYgdS5lHy3shLwSU98w=
X-Received: by 2002:a17:90b:3fc8:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-392ec629e24mr2228780a91.16.1786443527572;
        Tue, 11 Aug 2026 03:18:47 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412042dd37sm3752328c88.11.2026.08.11.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:18:47 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Tue, 11 Aug 2026 18:18:40 +0800
Message-ID: <20260811101841.804596-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811101841.804596-1-aethernet65535@gmail.com>
References: <20260811101841.804596-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain the difference between nr_snapshots reaches max_nr_snapshots and
watermarks.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 939298f2a9b9..1fcf0b8c044b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -872,7 +872,8 @@ the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
 non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated.
+scheme is deactivated. Note that, unlike watermarks, even if a scheme's
+``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
-- 
2.55.0

