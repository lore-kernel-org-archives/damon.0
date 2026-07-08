Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148813939B9
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495990; cv=none; b=LfjDY/9BF7I5Ki7aPipqLVq7rBE1SWccKeI4YwUOcmp9LRJbr8BdGYqrrbQvcpb5v30D7gST9Da7/0/8h167VQUVuIwuOjbuS7LbQ3HDSx7oK3R4DZaKRmSWnzqsqeFIDz6YeXiXSjXB5lT2HtG8UBG0hqfejioEDMuv+viwoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495990; c=relaxed/simple;
	bh=hmawTu+JUlpKtBWubzA+MUL/MgkXPLRQsMsQmq+7zVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1wC/Qogkijd8iq7ugYBbF4ra5HIb+IfQs55mNKCv/USdANvYIHo7yGuYjgwyU1vSFVJ/3ObH3aS0NegKiYei0qlTY/RJHUkjhwWyUxzKRfm5AFiCypz5x3aKVqlqA4uCE6foF/8V46qe5ik5n7tHAyuNXdtbX9ElkydKy50zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id/+DpaT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id/+DpaT"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-470f53bdc70so6520f8f.2
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783495971; x=1784100771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAmllN+se0JthLQV82NE0k64TaDaKEJudyrSmk0kR+o=;
        b=id/+DpaTM+v48mkBfP1Lx7+Ml+KD6ZIn/aseYD1hhFfczhihhe3pCzDQHQ3JsXeDbY
         MyLiwj7n4/NhwUeZ2NITcTAPp+ZC+UB/BSY6DkLXCdaeSTYrJHufPKkgbJYHosFGLN2U
         I8aAlAZbJIrKHrVoh9EuG5h0/0XvAo7Wp09mj7r8kaK9eReSqId/Afj8qwhPwztaCVau
         M23Gz3+BnniwZ0njz8kf+Sib3IxNNDmjtOh+er9VUNLnlM21RerjNnPJbv2sUWHco7lY
         Cez/0PiI2sqzWlGyie0kT2Gj5kxQYF0YDXxlYgkDFdiJfIJ+2Lg7ftighH6sVCAmbFdN
         sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783495971; x=1784100771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cAmllN+se0JthLQV82NE0k64TaDaKEJudyrSmk0kR+o=;
        b=ZlMgL/fEyZ7bGUlZg2V8RzV+cO+ub9JNICb2DTtl+nU/lGhOI1EM9VbnXOn/XgwuQ/
         BJ1szPlwsMEO4PgbriUfhTHn1Ks6+RskIgWK8HJL9rF+45ba0iIAEb3SNMIQ43SiETog
         rb22V0I7G8avZXBwV9eoiXsaHeXhbAcEiVvDdBTi2P40nVozU7hKKDhJOTEXrNlauMCi
         7IYacKUmSXrbRuNIwlMdL8OJD9tBh4pUDDrLIarJ7GUG8kv5COgFxvNpogjtV6Z7zHkc
         JpYdQMLCOCuISC9yNRZNqJa9KgQ/mMeWLFC4mjh+B9HL9jhMPEAOUOt5I7nsb1o13TDz
         Ee1w==
X-Forwarded-Encrypted: i=1; AHgh+Rr31EWG/K7h03ECNpY0vIhsoLto2XMvPNolNv8bHuSk1/MKJo5HBi3RT/EBSG1SP5E4l/H5Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsrQuIxMzNEXuAHLRLR/DWJQIXwKHqslE0ppVLa0O0aaQF0WtR
	04t2y6IDW4ZNDbMJwk1Mcj/8NewcsVwdyoLBqhR5Xb7FMoqZfN92bu6d
X-Gm-Gg: AfdE7cnVYf1Jd9HIbbzqnlWGPY25izq0FWG6JDiNyJ1ZDBCTpBme3us6ZmX+GJyeoba
	1gVzC0+g1szTEiVN/0u/H/8b6bOZlzJioIKlgphZ+5O7QrSz0MJxkRJde33FKnVTDUvxnMutwIm
	b9yVNshkxPfiJGbbcaWLLmJBT5ZX7ufA+CYGK+L8ZVGpS4K4foiBig5w4c0Q61fg9w4wnOgBBtP
	P4kR5V7bOahoR6EsAN8r/N4lXfQ8QS7eD7lw8JaE30e/Z3ebnWDrr5iqDNhMVXZv08kHzpakQw0
	EASoVZeUIXMIHHiD5I1QqFnwXJ3rDeK9dqrmSEDuMKYeqlskKlnOq0CfuGLgfiunOeswYDJkQUb
	1GeT7D0GwxeIJu6vaVV1YgdYLGoF+/xLHBrMNj5DZnMbBShl/J3Bj9qcqDWoNLsyywS4fG+Yp57
	FZnEqBCaNz31pRd/1W+FAeP5RYnQi0hxyuBsAyq7e9soCuuCp28eXrmzqVFwiw6ORhxkYrKwM6J
	yTrlZ1e8Glxiu5C
X-Received: by 2002:a05:600c:8284:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-493e684e722mr7381125e9.0.1783495970941;
        Wed, 08 Jul 2026 00:32:50 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm32876355e9.0.2026.07.08.00.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:32:50 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v6 0/7] docs/zh_CN: update DAMON translations
Date: Wed,  8 Jul 2026 07:32:39 +0000
Message-ID: <20260708073246.1652828-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Simplified Chinese DAMON documentation translations.  The
series is split by file, as requested.  It is based on mm-new after the
English DAMON documentation fixes have landed.

The intention of this series is to update
Documentation/translations/zh_CN/admin-guide/mm/damon/.  This required
choosing how to handle Documentation/translations/zh_CN/mm/damon/: do not
update it at all, update only design.rst, or update it fully.  I chose to
update only design.rst, because the admin-guide updates need its zh_CN
anchors and references.  Updating the other files would broaden the scope
beyond the requested admin-guide refresh.  I would do otherwise if
requested.

I checked the updated translations paragraph by paragraph and sentence by
sentence.  Given the size of the update, some issues may remain.  In
particular, usage.rst and design.rst were significantly outdated and needed
near-complete updates.

Doehyun Baek (7):
  docs/zh_CN: update DAMON design translation
  docs/zh_CN: add DAMON_STAT usage translation
  docs/zh_CN: update DAMON index translation
  docs/zh_CN: update DAMON start translation
  docs/zh_CN: update DAMON usage translation
  docs/zh_CN: update DAMON reclaim translation
  docs/zh_CN: update DAMON LRU sort translation

 .../zh_CN/admin-guide/mm/damon/index.rst      |  15 +-
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst   |  68 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst    |  82 ++-
 .../zh_CN/admin-guide/mm/damon/start.rst      |  63 +-
 .../zh_CN/admin-guide/mm/damon/stat.rst       |  94 +++
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 521 +++++++++++---
 .../translations/zh_CN/mm/damon/design.rst    | 665 +++++++++++++++++-
 7 files changed, 1343 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst


base-commit: db6ed2a3d31068ca5577466591b2521dee0508ca
-- 
2.43.0

