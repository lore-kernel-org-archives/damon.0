Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3843F0B3
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443543; cv=none; b=o04dmbIdPpkQth25DIC1AEjsmIdaCAoqbX5E1HiNIkFsejVVHda2PgCNegaK7pm52mOlvObKdPw8xdtRd9uGHaBMKilfR8OmHH2ugkrL66g7voni+peoKy/IfG5T+YYg6hrect3FW96eNBmT9p6B9sCWUSZTmCMfa4ico0V4360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443543; c=relaxed/simple;
	bh=X8XKJjSXE6DenhJzDaSygKkpBcmRawq3alZxZpVKgCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwF396s0dTGMx/qQhLebqzJAapik4Oln93/72SxWLurIm04NAJr4+l9ogxW7i1hmH4/ZvSqqf2SlzOvFwgYNhS3MUUV9O42Mfc9mxlm7QZ6yhLa9w/E0Pu7cyPtuqPlj0K/StVra7DXKhwGP4k2mw/raNtzG7RI+rA8Rc4tzccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYLZ6uMX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYLZ6uMX"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedf318752so9684a12.0
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443521; x=1787048321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=upRWsKe+PxidVTSoqqQjxjY/dJdukcCCjBrH3y90UxI=;
        b=sYLZ6uMXRU0hsbb3sqCmO9L3sOfQfebwnlolJmHa8sd9j3yPU6qWhkLllCx5hyydrs
         IWtDfI1T6HDvPxhQuCUKLNALiE35plwAQYxoW/NltkQKCydV0z55P/xJzt7/DDAQ6dYx
         PzIfVjU0Eo8qwQumh83Mb8lhKvseOuRtLRBaAWyiHFV55axYf+sA5U/42/Isxbp73hAg
         D2ONxR+VKbDf9JTvUpfK4S9soiyOCxgo+CKDwgdYKzI9kp0zrbqTu4kO7ZySSjppQYM5
         MH58swUy09T6fICOa/71e+DqYywG1j73jFcHEy0BdSD4JG2tSVXjDXGO0OY7s93m1KCD
         ppRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443521; x=1787048321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upRWsKe+PxidVTSoqqQjxjY/dJdukcCCjBrH3y90UxI=;
        b=U9CyH/j4R+aYherYBxU42rosLK/X1tUAyq8jyy2i00OB8+j1xleoCT1vj5NCO1L7IS
         6XG7M4v1ePDtXI2nzESLVPj1trK8atAFE2dm4TMv0GMHrmW7L7552MnTJLSHhxpCVJ0G
         fxy345chJQV6eVmKmJoUxxDiLUN+n5RDBCuQaiVelL6WST7q2aZ2mhNbIcOWDdIOraIL
         PZMX0B+Un0cBLHR/+E0l+2uLJH7+/sZFL51HawXTQ4LPlL20UaN2JrRD2ez9AcQLEB6R
         Urc0GDoI+WTicC7Epuu5pZlLs8genU5lXbBpc/qBJwjcFo6xPQvkqhYhiyWd0jmk+D41
         WGDA==
X-Gm-Message-State: AOJu0YwFZqtnXbyZkYIbZ8XD2lxVexXeEuL/HW+kYLUySdgH6Xid1nci
	R+4yXQ+UHivK7kOHfShAADn7ej1+vakKiSco8amyXvbdlYqrtqLxtlle
X-Gm-Gg: AR+sD11vrgW8T7ZegdeRDOnk+Q3JC66Cbc95zWat2lYMsTP30W5+WIvS/vVwnpCmziG
	PFNHKmmhLndq1PY0I9jp/EVnqaZasui/x3GTUZfh4v5ysHeEm9wCExkUR0UUhrhbwbkp6H2TyAe
	ceKg1QPlDOULDRa+xFhuZxQ3p4lDYPJJMQJjG0YpRz/E2dGCVazkmhd7J6weaMoE4jU3w9ybH2t
	tWdqJ2veITHi3+WUXLxj9Yzv69quu9aHR0677/vBwVW4PBenH7uiRCVbVVHSPtZ8IQ7fgLTxkjp
	4eTMpF+TQFlrAMPOjS/VZhot3/zSzZlp2MWcivACFxL+MWBJMalb7Kknbg6BYXBYei/WFgqtovC
	Wp3WOyMvp43w1xWg7WgQjE+d/gDLrK1esNCwzTiVE8vi1fiHY9yjlgAYQMU04G5okSwPvHX/sir
	yluY6HkyTIpTwrUKcF9PT2rA2MFrS886B73m8aLW5jo6/Csb3b5vT/knDGJC3PC+g=
X-Received: by 2002:a05:6a20:938b:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3cc2ba6e38fmr3152503637.27.1786443521318;
        Tue, 11 Aug 2026 03:18:41 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412042dd37sm3752328c88.11.2026.08.11.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:18:40 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Tue, 11 Aug 2026 18:18:38 +0800
Message-ID: <20260811101841.804596-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explanation of nr_snapshots to avoid misunderstandings.

Liew Rui Yan (3):
  docs/mm/damon/design: accurate semantics of nr_snapshots
  docs/mm/damon/design: difference between watermarks and nr_snapshots
  docs/mm/damon/design: fix typo of max_nr_snapshots

 Documentation/mm/damon/design.rst | 7 ++++---
 include/linux/damon.h             | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.55.0

