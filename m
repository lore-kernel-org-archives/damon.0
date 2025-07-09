Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A11EC4
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022204; cv=none; b=ONy8Zkpjf8jGwEybZgZ/dhsvlI07Mm+XwRhw1MzqAVyvHXEhFfayHOzdZtiWg2otGa0qsVQxKgdNfurqydVbIE+Q99MJuWx993GzQJLNm/FdJ9aGVVdmVTs/5pTIKT4oIPzyjfVHlhtKW+6d9S5UkUAebXRK9objwp+Yumb3X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022204; c=relaxed/simple;
	bh=NgldNzYwTkhlRxpEXq0DM09IquaTz8VFTwNZv++b108=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1LokhPg5gEWMbyuRPep8hQVomawDpSBozYiFEjebHRGIl4A9d8Cygy6H01uIya7/6huUtMrQE0BXBQRV5o6Pfp7ToTmLEmrtDTy2CJeMlujisiTxFZe6y51LyWwKFWohNeYpqw87peAsd4dknB4DKSWXdNSw76XdmFVi+H/5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kma4YBlv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kma4YBlv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710e344bbf9so46028007b3.2
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022202; x=1752627002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elsYwPw6zDrpvs+3bhsQ9YOjxpF7Z+Q+nAJ2MBwZBNc=;
        b=Kma4YBlvi/Joey0h9ysdKRudFZFWHHf+WjneC/W3yrzfaxuHQG78xdQloAT/u0pkGX
         x3Aq9SI4zlvXHwCic224md5G+0NXvBdrF5fpxR94jkY3/HwCGfBrrQjFlqIzkTh256IX
         6PokvlllV97gWmso6hXKzDRz5vfi0qtduiRQ786OtvsXg8JKP3UxOAFAFcII24EQ9kV7
         DuII5KO0ecWcrjHckyaPN5KycPYFFVvnjumtN1m/IG9VIz52sB875jEwWpHEEdLh4uNE
         CJnMlqnJErlUkYiDT27b+P3MfBQ3pnoRvmQqcduC6Rxr+fH7ege5c35MaZ3zd5sZCsX6
         gKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022202; x=1752627002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elsYwPw6zDrpvs+3bhsQ9YOjxpF7Z+Q+nAJ2MBwZBNc=;
        b=xC8s1EIEy0FBp4KUP0qFw16q8yhr4SlFiDPb9eeEvyH549a+xTsfldVBEcI6BpB+nz
         YEqvxPHEyomjvrEIqiG16eJWeZb8rmu/6kGjYdOC7f3v21en0prksfUw6HnZynjbuUfO
         fMDilWJYGKgYm6VozvNT4T/uSSJEv45JJjv+NXSIMeEQecmCoyMAXLbBBtqilT6LPDtQ
         pMrllooi7h74rrDlFZjgpZweaQrxR7PqlYr2KiDiSBKXzQ/ji8u81zCGIdEFeIXoiGTB
         NX5osaGr7dj9OERc0CLPb+0vpfu120gqTj6nh+Ec8bdn3CgTO1WP/aySwupTSqZ7f9gz
         vn7A==
X-Forwarded-Encrypted: i=1; AJvYcCWUnSAXLitZZdp27g6em4i1VO/8pDeDTPpqCjl3ovtD1ffhn+Z9kUDceFcYYpxDYMVXf9lQ1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQSPc1snEzVdUfwpepbPFSOZO6D/NNU0kgXkHetgnF0h1r07cx
	JkwxGnt+9X3dDn/EUSoh0UZ6Kfy7neuOcC8gIhMzMNR4nyvTxmgfTiQB
X-Gm-Gg: ASbGncsLlXWPuOLiGelcalq6K1vFM0bpX4QSqQgAMuccll6qtNKXpZAZX1KbInW3InB
	uIzQQ01iJAbvtJWi1OKQFL364i2hJzQxicthnj/ZXK17BmCJx9k1EEk6NelL+AqScDOKNdFABLg
	DbebWuLU4d9qJIUqBm2tvC/DpOhctXjq3J+KC9XxyB8DE4dX1SQOAjDKdYoPCn2bjVpuYqr6+d9
	KS3MLC8BtJi491XY/kVPLLfAPGMI8RQilrY2JFKaglAwqNUwf1ONKylT/JzUHW/k91ymsVLZMSZ
	ZQYCaRtTMmMGvhK5ti88uaKTLjjO+8JRPnwZb8fampW63Gec7uSlknmO/aNYpEwnWJNI1eAuzsC
	O+zmgyl5qNauPdztJrw==
X-Google-Smtp-Source: AGHT+IFrSrxMMJNXhy4I6nDgKxzf2q+J9ki4um8/p2fAqdLKruaJOFqYiuZujRclanonBZPwLTRzeA==
X-Received: by 2002:a05:690c:3587:b0:70d:f338:8333 with SMTP id 00721157ae682-717b19847b1mr11911327b3.22.1752022201951;
        Tue, 08 Jul 2025 17:50:01 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b40d99sm23563877b3.112.2025.07.08.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 17:50:01 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: Commit damos->target_nid
Date: Tue,  8 Jul 2025 19:47:29 -0500
Message-ID: <20250709004729.17252-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

When committing new scheme parameters from the sysfs, the target_nid
field of the damos struct would not be copied. This would result in the
target_nid field to retain its original value, despite being updated in
the sysfs interface.

This patch fixes this issue by copying target_nid in damos_commit().

Cc: stable@vger.kernel.org
Fixes: 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()")
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5357a18066b0..ab28ab5d08f6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -978,6 +978,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 		return err;
 
 	dst->wmarks = src->wmarks;
+	dst->target_nid = src->target_nid;
 
 	err = damos_commit_filters(dst, src);
 	return err;
-- 
2.43.0

