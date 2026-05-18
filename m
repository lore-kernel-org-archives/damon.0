Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E03845CB
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131540; cv=none; b=C09J9KGf4RU2lTxRVimHqY59S+dZoNHf7xnj52F6IpyjL7critKKHcedxKtneoRfByck6AvaI2MQgEQJ7xJ+sqL0JFVmfHn5mGmHWy3ZZgFDwnGUX0F3f5xES+J3A8SAJr6sPTe0JFQ3iJA8KPrmg+qslhEmCNPBkEahvna9j9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131540; c=relaxed/simple;
	bh=dLOJNwezgriYhO1PZqtsX/aHxzI/yIGU4juBcSFDAu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVYnWP5yuMwOs1w1nFi9x9yDKbeKrl3g9ULCBARo5FmmOG/JGpXd8wEnJbeYWkpzS5nry44CS5O/JeWU7FIHjjpYUDfQZLZUOuqQhHO0clmm3GsYxz4P5zSO6kaUg6dzhRB2mEfbVRDDYFhLnrwb1NGhLTHxDpb3QMqctgvSqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7nJ0m0u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7nJ0m0u"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d102471a4so21907415e9.2
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131537; x=1779736337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGf0CT4yKcvvme5mdnXPLSkPCDM5qKcEM+nXnBaB49Y=;
        b=j7nJ0m0uQ8g9gZ/US2K08l7E5FgN6yFSpCv+tVpR5a4vGsF612rUn1/BCRzmWDCEff
         GZhU9ng1IqeWPt4KwYXXd67zpq+bcPqSnkVpSzci344Cv82I7bD6CcYZomv6a3SDYwCB
         pOs6rMPSmD8cpShk3XQmRoHwfWe6BQlTvWjuLrWVljHvaKkCPPzNVld5c2gs8K79hcAD
         eXqJ2ZtZuyJuQqY60vhL6UNKlNaSuiYnBlp7DsJ4wS6ll/rt15/LoDJxQt/Hksckpafy
         Z8IykIKr1gmRnFlDSc7dV1bkqIziLgMll5sE9KnHW99wvA2icISHXUdRmDS9ujCpfVN1
         OYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131537; x=1779736337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGf0CT4yKcvvme5mdnXPLSkPCDM5qKcEM+nXnBaB49Y=;
        b=d0NHhBGxuEO57M0hknpv8C/Wey32HdDd8KLYo84a3+MyETJ74ZgbGlRA4OHxmUlt4p
         3W3kHiRzCDcbF+YMIXK8HzSl+KmWlTLYLHxQpxV0SaQM10Hxt9zV9UKCnhHhtOQzHmH2
         UQxJhpSpqYvlDjYCf2NIwJsVpAx7RhtyxhbXtB925qOw5XFI5uWla1OKOlgWNSWZs/ht
         UtI862GfPod+xuDBsp7YrejJVcEJKP/XsUvGs0JFjesNKQSRyAQP+EVfRrIlFd477ab+
         rthUOR/XkQ0JI/G2Fp1g1SxQr6l4gCtw2nGkLYCqzoKlbTq8ugkIn9YjWNZ8b9ApkRUh
         qoiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mMmH0Ee3tmbONYE6fE9BoH8mvudK/JYNC9EXrM8v4zZPFgrv/WCeSIveWnVcgyasr1Zs0cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0+Zs/j+Tgx5TaUwAgZOBKAW265hrHmZHAfOTDzHKaY4EBycIC
	YTTieB9LcDF2Xg3NVtPxdKJ8JdTdoUvZBI6SjNTuPWP+RW9TX5RY3yOU
X-Gm-Gg: Acq92OHmZKIDe+mmywM6xftU5bckbtE944KvRMidDdBP1Txxme2Jylq/tYz6EkNnLAi
	O+alJkeG2RSl65yqG9gvULKanmt9kkooMECQPLYqIlXGSxSQCx/klXOeIpIa8jlL+inxU0zvFNa
	rfk3JzVMdBxh6psxgBP5ZcQML/QUheYaqy+QacQyK1bqxfGGBQwL3tzQtAtthWSFw89feGrHceR
	a/cFGXf7RFsGL4xb01J/HU13A1IMkF0q5aQfjuGITT8HOzwfjkVjrEzupsJPhUkYhVJ9qLUDmsl
	ZHTkWYsnkujUKNnAsSpbIoZgswpgExTvn0pjzSrZuQuXg+uRreYXPhDiQZVayYYEJSIAQaEVFd/
	eeq34KCRdsPZel4NXb6ZEtmSCgRQm463Kh8UgZDS/opkU7tjp4OVAlDSTTdHpRj+hRfSbtAX4kM
	hxSnLnO6nTwAlMr88yxMPiHl5M5MfXj1Uh524WHP+3MSPY82IwIoA=
X-Received: by 2002:a05:600c:a11c:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48fe5fd536amr192002785e9.5.1779131537200;
        Mon, 18 May 2026 12:12:17 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:16 -0700 (PDT)
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
Subject: [PATCH 3/6] Docs/ABI/damon: document update_schemes_quota_goals command
Date: Mon, 18 May 2026 22:09:29 +0300
Message-Id: <20260518190932.42270-3-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DAMON ABI doc for the kdamond state file input command
for updating the current values of quota goals.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ee29d4e204ff..0bd33c1e6790 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -36,7 +36,9 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		kdamond.  Writing 'clear_schemes_tried_regions' to the file
 		removes contents of the 'tried_regions' directory.  Writing
 		'update_schemes_effective_quotas' to the file updates
-		'.../quotas/effective_bytes' files of this kdamond.
+		'.../quotas/effective_bytes' files of this kdamond.  Writing
+		'update_schemes_quota_goals' to the file updates
+		'.../quotas/goals/<G>/current_value' files of this kdamond.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
-- 
2.43.0

