Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D8329C75
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550148; cv=none; b=iveZeTWzT6SKIF0p0ynoGJHHPN87kcmuT7gXyi5tt1I20Jk7NYZPRZe/v6Oh4ex6deDsAHmrUczt5j7eWC7PrZFiC5RwhvhkOXtmKfwZavtBvThR0cKb5h8BWpLdUp09NVaq8NL2Y2cMbJmv/NzOZnL1ogdB62ReG/eJcj7+LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550148; c=relaxed/simple;
	bh=YWzv4mR6lx/LhKtGrLACg+b81I/0rCPwOCqzO7QxXro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VATy5KE5pYPfZTmHQBtTak14OQ9/G7KFlXMUONG6y/XYWL6s4jLz60G2wKdToDniUYtef8Q8yUGFv9hQeLkIjQu2NdHw0ThDjkVVLn6aLkw6Vab7BiZoq/HazhoRwfU0YRMp/GOn5F7m5hf2aMqTjXgMGOMqZsvfR75PqYnLYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpKC44F7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpKC44F7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09757004cso71179575ad.3
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550147; x=1767154947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8remLMvBFK5RUdUzYsP7LKIRjVVtdklxr8EKcqM/1U=;
        b=kpKC44F7RwDfi8aT9EA2sz68XWNJT/X2QjYmjox7FjcV4dU546VeEuzEeASSciVIWA
         GDnfxh/Jr1Ixfdw5sPIHkwnQIgxaxIxoYldlTA253BwajXV0IC7vmcSeltUHp95+2Pok
         QrfGdKnRvSnSXqgE7vLk8jI3yJWdZnILgdML9jsQG3XXopDPymlMyFsAQ8rGXn6bksYb
         V3dL4RDKk3/r8NhTOgdmsY0zylgr7gyiv4qO9Jw72GNsvmmbVCVKVESzwEgo8OZyuxTu
         Axusav/DX9NR0PFV+06pcoHb0tlBCDa6pS76kYmW/8lZ1Qn72urbbXGWrhKr1qI1evOK
         Jy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550147; x=1767154947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8remLMvBFK5RUdUzYsP7LKIRjVVtdklxr8EKcqM/1U=;
        b=jtKA4SRXliuTO0nt+v6yXvCs792Nh5MqAB3iCjmGJktxxLDCstsCiCvQ/0e6kiyMWv
         ADIJMwfAucZ3nt+ly6SFzbTZHVVZ4bXHTaRSC1PJ6hqfAeBXHxv2nZcTsKcsDkuXzvj5
         G7DDN8a/MgJqkCq9sotVLJfcVlXd7oYNBB2jCuiuoe8IjT2IRHLAftR5g9XhCqEQNPc1
         1Xk7w1ejx2bLIvS8VnKhFr4iL3U6bOnbfuvwem4bBQjOz5RGWqYhnkgcSfwXz33UVbD4
         rT5t76Vt9N3ZQNsZn/lfY2QIg9E8FRNQgq+6H7BPr+mdDT/R8RyjAlPstJrg5PMsqqTO
         FsrA==
X-Forwarded-Encrypted: i=1; AJvYcCW49S8tfkF74YodI5oPyxYtTt4SKt8pI/qfbHrwOeHT8742wQ91ueCp6QO1QjXGMLVE7B+/TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl4A0Xf/xl3PyBGaAIgS4YhZIprLZMEuXWw32JJ8HEF8dbgE/m
	SUwQDivtv+EOVhp4P026B68RZJP8NGJ/uqWaa4Y/KyzLDuVnGpBnQO/0yOx0b5+E
X-Gm-Gg: AY/fxX7iAcqIHRUzAr+Ur0lKp3w5K0Ssbbur721nMpdYKRY6GKGK5ssFeP2uPLqG05y
	BOM/WlO+jUDD1v+KEwtQAFD+MK25XB7cwgNC8lHLAtPaEJgDuIGQQ9SxnRii91FfP9Ii7B+rOgp
	qD0DuLV7yLWqaIIJhanfWEjsGMQl961rtl6Gjeq/nN2RjB7OAOs/4Aqn6TBmCNJ6zeyMA2nxEKj
	585qNTJkc4SzrKuANGJw5q1xqRZ0KeHQs4oYSY6iYrlbbeM9pqTG8oEM8phxqkjP1A0bH7msJq3
	mEO2rJxUK5EefNkiMZPW7FxZw1a7IXXAiYQk1CLQtbEVergh0d4rU89VYDuPWJDO99/Zfj3Yp8C
	t4LpFaMyHhMKZoAiIUFLpNCnmCfgdde6yuvdYJYtWSryVuTau2faX/eCZs9BMYpGEEHx6p5KfVw
	SkTHvkdOuAUmmvw147iXX10Q==
X-Google-Smtp-Source: AGHT+IHfPiFWmZDW4o5w7sYzXHS8vE/zaayVH1U7R9hjLU9hYqPevU+4g14ejv4+rRb+HrXioe9eQQ==
X-Received: by 2002:a05:7022:2586:b0:119:e56c:18a7 with SMTP id a92af1059eb24-121722b4e90mr16067286c88.15.1766550146638;
        Tue, 23 Dec 2025 20:22:26 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:26 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 5/5] mm/damon/tests/core-kunit: remove a redundant test case and add a new test case in damos_test_commit_quota_goal()
Date: Wed, 24 Dec 2025 04:22:00 +0000
Message-ID: <20251224042200.2061847-6-shu17az@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224042200.2061847-1-shu17az@gmail.com>
References: <20251224042200.2061847-1-shu17az@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a redundant test case from damos_test_commit_quota_goal() 
as it is already covered. Instead, add a new test for 
DAMOS_QUOTA_SOME_MEM_PSI_US, which was previously not tested.

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 36622a2c11f1..4bf1d172436b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -601,9 +601,10 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			});
 	damos_test_commit_quota_goal_for(test, &dst,
 			&(struct damos_quota_goal) {
-			.metric = DAMOS_QUOTA_USER_INPUT,
-			.target_value = 789,
-			.current_value = 12,
+			.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+			.target_value = 234,
+			.current_value = 345,
+			.last_psi_total = 567,
 			});
 }
 
-- 
2.43.0

