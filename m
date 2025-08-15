Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FE2F83BF
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250847; cv=none; b=uLLJLlrKDYs/dpTUuJinBcI2EFiNeYMpWwSfpaDMKfUsRZu7F6+KRDao99ODOaVyXbJ2KHVuFgxq0/hNGqFvyWDyCaS5yCrFVfEO5vVQC0y2z4T6JXvOL7ru5xGROouyCnzP3MlQS83TPDy0GzlSiZtZuwmpV0gOpCAQ8d2Aw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250847; c=relaxed/simple;
	bh=5V55VRwGcflQoCr8J+YXNCCvooL/TNcr3ShpDJVogV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6sP9ONAEvvVgrRC/EDAFwL0+p1xe9t71QyVbZ9dwBw1MHy9QDVTNLDJ+zyrnoLYPwHbfBRVxat8QxApxkDZk8Xi8wfKRUUSwl7k6S5z+kwArRqc2W6l+g54Y75GNwK/PYXL3RiXjAVdfud7NSE2oTj24YtnxFUINaZORfQF+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h20Kv4Ej; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h20Kv4Ej"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so2040689b3a.1
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755250845; x=1755855645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EaYU3byF1ibThR0UBznWnxi/raQE1VP/oaQB9ZX8A0=;
        b=h20Kv4Ej0zrZmBjURfwLpuB2rTl46bFaqOhJ8rctOXfoM5Oy05Wa9N4+oWqUCkML3t
         clRtyOVGYa5OKKH7KdSrfnS1R0Dn3frtcuU+cwPDhzdTaMZBnZfWUutopUCnUgicdqGD
         t7NT4Mnkdc6VgsXGoAuvfd92b5ZdQSIsV9U15j4YeTFmBnQ7LBrM3OJ2Tcq1ydyqIqtj
         ru59i98PBuWd0i25Js9nYIAoETB9t1rHdbf9dZ8rRBuik9CO0Jmg6+iuIt6NCFw/XGpt
         DgV7ZN2hqKBJyjES3dDOF+N2HVrkY8UXTFE8yDTiVGu799ApM6Gle3kehBZz/GdU4Usc
         T9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250845; x=1755855645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EaYU3byF1ibThR0UBznWnxi/raQE1VP/oaQB9ZX8A0=;
        b=TlFvosJf7+cCSpo7jw31/9vIdP4KzizxdxSLdewuKYtezozevpVkEOZM+DXZ5mts7M
         94Xd0b2tNFfhSdynQCqTh/hOsfnC1SilLuPRgdLB73ozwqODqXeKzn4PvTONX48yzbEY
         i7gKg/5XialUxxr6HlT0UZ/qBUO+7OeUNg3Cm0I0172s3eq9nRK6s9sYu82HoH4Hr9z0
         Ymi5ay28s00EbngPCFBGUGMFSAIoCD2ZE6qSxDICls5Cqpxc6lAu3FZYHA+ET9F+gKFY
         6zYk8QJY9th/2wQuc8agNLWcugqZ3ZRJkbBTDBkcbQh3ijbMpX2QcWkiiptVN/mNG/zz
         RgMw==
X-Gm-Message-State: AOJu0YxzWfQNuCTQJSWMQcPhNsWaAw2JjWp50sSmHc3Ic+JwSpMKJPlR
	B4GJmdnP2xSQBdykg7eQNjyzaXbiI4OwRslAatm5GE+Mqn/NdSiRssbv
X-Gm-Gg: ASbGnct9CtLZyd5rgZUqVqd6TYBczntTV2AYH5YHHduhSa6kSH4WSYm/yQSoQniEmL1
	VbS7x7mb3hLy9sepSdCTz81abEFD1fDvMMAruyrP5ALU3lQjwyHrtNMDDKmnNcRxuIKje4tcYmL
	WuNAFu1JuZqkzIPFZOjwdvm3fUud/i34jM+uQza7/YakZW5agYh1FKMtc8UwwXx+qsK5sHOBKNA
	/ZqbXYhsmPdrzhxL2RxtuCWgnO5ha3/KD6PJT6lveB7DlXjsBT9gOuUXejThyzilK9x6sK3Icrz
	zj1ztFCveJanSlLiNss24A+EYvoZ+vjcM+t8hN3ezL/Px5J+r7bUDJv4WtEUh69SkfSN++RAi87
	Y166Js/v3Pdii6Zy2
X-Google-Smtp-Source: AGHT+IEY6R3cStHuOBLGITafHPzeFrieZ36L/mlZDKfN6ZZxS9bt/cltVMPRkdogNSr7syQ3ssz5fg==
X-Received: by 2002:a05:6a00:3c94:b0:76b:e868:eedd with SMTP id d2e1a72fcca58-76e4481df98mr2161303b3a.24.1755250844960;
        Fri, 15 Aug 2025 02:40:44 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4528c807sm767087b3a.41.2025.08.15.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:40:44 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] selftests/damon: change wrong json.dump usage to json.dumps
Date: Fri, 15 Aug 2025 18:40:29 +0900
Message-ID: <20250815094029.133063-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To print drgn status to stdout json.dumps should be used without
json.dump. Change incorrect function call by typo.

Fixes: 441f487d6ebf ("selftests/damon: test no-op commit broke DAMON status")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
First I'm sorry that make you guys work twice. This is fix of my last
patch [1]. I'll be more careful next time.

[1] https://lore.kernel.org/damon/20250810124354.16456-1-ekffu200098@gmail.com/

---
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index f557587ebc81..2c65cffe6b54 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -62,8 +62,8 @@ def main():
         exit(1)
 
     if before_commit_status != after_commit_status:
-        print(f'before: {json.dump(before_commit_status, indent=2)}')
-        print(f'after: {json.dump(after_commit_status, indent=2)}')
+        print(f'before: {json.dumps(before_commit_status, indent=2)}')
+        print(f'after: {json.dumps(after_commit_status, indent=2)}')
         exit(1)
 
     kdamonds.stop()
-- 
2.43.0

