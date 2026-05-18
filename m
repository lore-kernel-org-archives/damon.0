Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBF38F255
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131524; cv=none; b=GczFO7RAF7FtPGbj2TvD+eDeIABJGe8gL0Depe/BZbTmnjlbViR0hocbBgIy/2jY+0yh0IYc0h9RKtId0mjrddXNxh+GWY6RQcMqVF4pu9P4R3lvar5I6vUepW/hubvrG6fEsmgBc+EX0gum4ukCllb+B9OvpE/SaCD0u5+WbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131524; c=relaxed/simple;
	bh=SYNaiWE+6z74HiqRR6DYEYa5dSi13wZDsECVnOFu4jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxqGR0B/rDVd/012/iTWMxF8npefrDoN8rk4GuaSi0KS0nVo2Pnx094XFQ4bv+ZZQmFBGKfbB/HVWvqQ7mEvEs4qtmbiOxdJ9cMpIK6b8CXTiuYNfIJB34OE0SyK9QwXy3hyyJAlhbddYo2JdKyGuw2OpgpjrrOaOu/jyxON8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdsBPR/k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdsBPR/k"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so15542105e9.1
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131520; x=1779736320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgjcDSkJV3GKfKlbUQSZ57rr2po/MRqPRPN+0UqD+s=;
        b=cdsBPR/kFYhTgJ2ZnfZNZP5faKO6Nyye+47e2g8mCXFd9fpnEAVXuI57bjnxUNCFmS
         cfG6mKN83wN8+eXp40ECCe5+XsgM8kaLXExNy/ezFpoox5GKKTMw704kA3j0rDozs7xQ
         kyJ8RxD64vO/Ix46v4d/Saqq73awusfzynArIYfrxLFEJF9AWGF7+wYn7YaK6kGgQvHQ
         3zptnHMM4HwR168VzjCYAINAOrTSUDurCyHZEFgABVFTZWTOA93Udq6rVFYNsyt24RX2
         EtRt9gOtSrynx28ocfAonTWHShXbUFIKwi6pjQUmxALvsU433rf5rhUaTXeAZUzl5nMU
         XlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131521; x=1779736321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdgjcDSkJV3GKfKlbUQSZ57rr2po/MRqPRPN+0UqD+s=;
        b=d1Z+a+qa2yq4wZf98q48rmnqVTGFqeBH1F8wd1Y0QZ27vUu+uxaR31nEkJAZJjKW+p
         RuM4fjyRXmw5QoO5mGS4jEihO04sg3te+r7ZeDw/nEF3QGTygIDNHiF+MHdmuzVT8rFB
         epauRowLO68MLoYv4CZ1rSwwJ2poKclc8QmYIs0gqIcLpM8CuwhNbc4NLCQKWuDyVt05
         bLfCQdgKpyqs29MNP5zI3TJh51ghVVTIu5yvvPat2CSHX46/TzyaiSxRhQNUVcaLO4uu
         8wID9tCfKRvBg+fwHy1wFpqQC1ykmjlW8hnRGYtW5Uen5JW/E+iCe2r4vFJiLvKO0Hrc
         s9oA==
X-Forwarded-Encrypted: i=1; AFNElJ/iX93ZoxDg3DHXkXNb5wu+tDDnVZx2b18PZrD31cjxtEDoA9GtYVwhSyWR+S6do+2wjvku7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBE4JRKa11No80BmInICXhqAQBDuaL1K1oDaFN8fRISAolr1Gz
	CO0sDlBd7TkmTkeFDAM+oz6XicJ54F3DMcNJRrT3Y8TxVFvwnQDm4tkg
X-Gm-Gg: Acq92OGLmscJVxv9xWMP0zA3fVk/w3gr8coreBSzmBwFKAJBmyER/IxjIOod3BcwFFK
	sdwHv9TuwXxZ6e6nkRcqWpGGe5g1NY7cCffxZu7wX9ijVVQTfiS630W0FmOCh3wd/dYE77YUVh0
	z/MWsTBtMDzoGiBkOxfID8ztLQ+kOO8gDhUXUey5n3RamsExBrvF6TvGJTl0Y6UmzWevrs0ZCfW
	KmdMfXuWmE3liXltb2POaWa0GnzG+lTosM800saDfPzTre7+qG132K5T71Sjw3Zw6bGoAy1iQlc
	TRgx1ys9zatlJWZDdCPUZJ9hP00dXO88JF5auFfLEb4rlaRcKJ0IJJyPK0zpI2VPS4MkWTm6WVh
	dQ3hIrwhIbkg8WReyGCyICyixvUimL9vLkIlxzFg5lPQi98awdw274bB8ywysbNa4T02vn3/I2e
	qrPCfAaMVCxyJMpM8yFpnNGOYqEVt52bBLuwSCJhv9OsSGNjaMGGk=
X-Received: by 2002:a05:600d:644f:10b0:48e:9134:6ae7 with SMTP id 5b1f17b1804b1-48fd62d9be0mr228420795e9.0.1779131520505;
        Mon, 18 May 2026 12:12:00 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:00 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: [PATCH 1/6] mm/damon: fix missing parens in macro arguments
Date: Mon, 18 May 2026 22:09:27 +0300
Message-Id: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON iterator macros do not wrap their pointer arguments with
parentheses. This can cause build failures when the argument is a
complex expression due to operator precedence issues.

Add missing parentheses around the arguments in the following macros
to prevent potential build failures:
- damon_for_each_region()
- damon_for_each_region_from()
- damon_for_each_region_safe()
- damos_for_each_quota_goal()

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 include/linux/damon.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4d4f031bcb45..32f2318ac77f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -902,13 +902,13 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 
 #define damon_for_each_region(r, t) \
-	list_for_each_entry(r, &t->regions_list, list)
+	list_for_each_entry(r, &(t)->regions_list, list)
 
 #define damon_for_each_region_from(r, t) \
-	list_for_each_entry_from(r, &t->regions_list, list)
+	list_for_each_entry_from(r, &(t)->regions_list, list)
 
 #define damon_for_each_region_safe(r, next, t) \
-	list_for_each_entry_safe(r, next, &t->regions_list, list)
+	list_for_each_entry_safe(r, next, &(t)->regions_list, list)
 
 #define damon_for_each_target(t, ctx) \
 	list_for_each_entry(t, &(ctx)->adaptive_targets, list)
@@ -923,7 +923,7 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
 
 #define damos_for_each_quota_goal(goal, quota) \
-	list_for_each_entry(goal, &quota->goals, list)
+	list_for_each_entry(goal, &(quota)->goals, list)
 
 #define damos_for_each_quota_goal_safe(goal, next, quota) \
 	list_for_each_entry_safe(goal, next, &(quota)->goals, list)
-- 
2.43.0

