Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A81C5F10
	for <damon@lists.linux.dev>; Mon, 20 Oct 2025 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939945; cv=none; b=NmgKiwId0K8mFWmhDl6LHp1lMXqRw3hW2Tkwm3/ee8u60u4UWKYhveYCQmFdYvhWVgynMFA1wqF1Hiez2hSh6aZ3BCt7yt57t6EKlr5BpMyhFG14f0nWUkwdLg3KUfE8+XOSvMGY7p5kU+HFnRbooBMrl9n1QuP+RjU6jOZWmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939945; c=relaxed/simple;
	bh=9YR6zpuuBYh17jTYGfG7SF0gY2nQCz/46WAN+cYH8rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEN1D2h/r84D5tPSS374JWNOuY9iCVbS5YOb2DVmzuFL8Uxe973ows7ABFIZVtKLh4h/zTep0GudL5IEOBUmF2jfSt/IgvNxfEZOUDXXr0d9IaAxWWCIYWDi3KCUTLnRhP9CFpK/fk9dEM/zJeKoXi/8SNEE4I21Mgzdn0XhPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0k8RTH5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0k8RTH5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67684e2904so2738971a12.2
        for <damon@lists.linux.dev>; Sun, 19 Oct 2025 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760939943; x=1761544743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jh6W7krdQiiiaYxBqeKiYxYtQ0S05p25BmbNHj4vO4Q=;
        b=V0k8RTH5QVpd4THUHlSSXBq4fdZHwOycpYmq+JoIRaAFwc3YA8uDgBIFzqDoSCarLH
         aF99DLxLoCSSZ/4Y9fTaSqU8iu+/fk2LEUyBk78G5FWY9f9/egHmtVABw956en047RMF
         r6aKMz6hTo7N4wNrytGJYb2lusS6NWAhQBlF30N8BzptCjJUC1Me/M90AlJa+lmCvHTW
         3jxS0GFq7bEODYbar0STxiFtj9vySxmhdCTZlvIEsNPy/FHZNcEA15xQI7Fwl8DgZlzc
         NAABi2oKa2MX6zXYoKg+hM26EmScfRxN2oWTb4lRMM1orvagrX5+PzCHAecD6c0nO9J/
         81tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760939943; x=1761544743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh6W7krdQiiiaYxBqeKiYxYtQ0S05p25BmbNHj4vO4Q=;
        b=C0eNDBhQnYqF6/N47QiNj/b2u2jkTYVAcgWcOZQHoUJBaZlaUBnI1IeyaUPWZ8ePo4
         Run0E8pKGegc8UgjnCZwHLuBNoPGs0PGM1zE9lv0o/t38RlJ3eTCwUuru5CBd6Qxrnpx
         9Im7/Oi4jAaPXdFfIul2mqsVXhZbwYnPYLz/2+pKGk1SYpvhVWhEiIQBnZxmfiZAgKFq
         uO5VXwDMqWtfasdffi3wWxmSSWh0wkMR7dzFaM2C2L5SRTaYXiHDyzwleQwF9G8KceUd
         RfssT8XnAO60VPOy72rLokA2JR9xJmM0Y0D8jQzjkiIK/MX6q182VTh8srzmKkVDQ8Sf
         z/SA==
X-Forwarded-Encrypted: i=1; AJvYcCVHoOwPwN20zxbXUww2M/zRJA4qB5KdAwhE0ZahE9beoQOMSLfM9/lNrekyFfW1ZHu3fs5E5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWa1+TgjRXSgY7/vtYMCI57Uo/aOfTUUJnJzHv1wyhJv2gBESf
	g4KuuHEkfGS1deBmvbuLzpgUTQjpXbjDjCYx6GtmeWiLnGZ8XK5XgZsR
X-Gm-Gg: ASbGncvdSRY2ySSdXp+RTrxFermd3wks/mVOeqdOLfyNaNIXC5OH5XZGGdEc4ZLa4vM
	0ybfYD2RStGB3amYZS1ZdEvVN51GHyHAHNz6iL12OISaGr9bW1uTMAq4ondZ9pZz6/FWAE13f9e
	O9TSm78p58thkoqePt6O9HBOeVMh1GnMRBsDGQcyy4LTucvd54wjKYYtV9O8FEb+OWa6qqqI7Kh
	BS67uqMyURrP223uaEv8l+jf3KqKRYVK+/QE++W/LqkEPum8NfXKt40lFOZd61K2FGr5xjEtrQ7
	r/J88uF7F60JQolLZxAaez+UYLcn0fdbOdLhio9sBBKtU5OduG5yIseQR++cmWfBsdPMAy2OZDG
	ZOTdDDHGvT0w5PnX4bzVZ3kqIyVgkWcv3vMcNyfwKAZr4Du04xys0ptf3DZtYaRrCVqu8t8asoL
	Z6IPfioqpM
X-Google-Smtp-Source: AGHT+IGlZYGHdGgTHh1H3IPWV/+DfKsNTbrDi5Reqk7UDbn9zs+s3vYh2q9TI7qZwuSkPn3vMBTWxw==
X-Received: by 2002:a17:902:d584:b0:275:f156:965c with SMTP id d9443c01a7336-290cb65b61dmr142564905ad.52.1760939943138;
        Sun, 19 Oct 2025 22:59:03 -0700 (PDT)
Received: from LilGuy ([2409:40c2:115f:7331:acce:2657:d834:4048])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29246fcc795sm70386805ad.30.2025.10.19.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 22:59:02 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs-schemes: Validate nid usage in nid_show()
Date: Mon, 20 Oct 2025 11:28:24 +0000
Message-ID: <20251020112824.144391-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nid_show() function previously returned the node ID (nid) without
verifying if the goal object of damos_sysfs_quota_goal was using a
node-based metric. This could lead to incorrect reporting when the
goal metric was unrelated to node memory.

This patch introduces a validation step to ensure that nid_show() only
returns the node ID for valid node-based metrics:
- DAMOS_QUOTA_NODE_MEM_USED_BP
- DAMOS_QUOTA_NODE_MEM_FREE_BP

For other metrics, it returns -EINVAL to prevent misleading information.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./kunit.py run --kunitconfig ./mm/mm/damon/tests/.kunitconfig
- All 25 tests passed, including damon_sysfs_test_add_targets.

Based on commit 3a8660878839 ("Linux 6.18-rc1").

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 mm/damon/sysfs-schemes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..23a73b94fe53 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,16 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);
 
-	/* todo: return error if the goal is not using nid */
+	switch (goal->metric) {
+		case DAMOS_QUOTA_USER_INPUT:
+		case DAMOS_QUOTA_SOME_MEM_PSI_US:
+			return -EINVAL;
+		case DAMOS_QUOTA_NODE_MEM_USED_BP:
+		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+			break;
+		default:
+			return -EINVAL;
+	}
 
 	return sysfs_emit(buf, "%d\n", goal->nid);
 }
-- 
2.51.0

