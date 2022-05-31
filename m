Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECF17C9
	for <damon@lists.linux.dev>; Tue, 31 May 2022 02:04:32 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso115211pjb.0
        for <damon@lists.linux.dev>; Mon, 30 May 2022 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVmLfgn1Nm0LiEUGoHnz2dUGee44h4bxPJzSoBNxosU=;
        b=uos1a+yHGla5I6drZ9n+twHQmjFUu6SMLxAAfWu7H8cv8HExB6g2cQTVyGmgnKTCEk
         pAagV+KHi6edesy4J8md/RWFKce8nc3wPtbxqYYIUbtCbRgoZeaa8MNgCld6R0U6AZlN
         L9kE5+HYnVFFRTQq5aHOyNhBBoYZSr/vQRqjQtPm8as8FHeUGqIlV/9q8ia9WA0Oq642
         fcF33pHIdydP4sOxGuZgWseVrT2eChQ3dqWiimur9ncs+ilqT6zIbVitx9Qx0ABtxKgF
         IXMU9mK/D7n7vN9LhdYfrtm/hgwlxojRfP/6Aln0D+GVLpODRbQH7wNc49Tt0bkiPut8
         g4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVmLfgn1Nm0LiEUGoHnz2dUGee44h4bxPJzSoBNxosU=;
        b=M+TFrfI8Li+MZcJdTadTQGodlhKo40j7Ya7GDcDTCstkkxvpXXe7IRAbtqPcyLyHo0
         wFeJICrvwofBkKthONJAmvda7UzrLvvCsB1pZH1BUQ1f57DwqGrjNN9TtEIORWVfxi+M
         hTo7Gjskk+XjT6FTj6XT9qVO5w2c0VGQf4/kw9odYGp7TVzXNeompciEu2dtIAuWfJ3L
         SGlB67RSjvDZiTfvTcTqhftVStIpOZczujniS56V8aT8/TqTEmKfvi9iJIH7l4X986w2
         cZiZTx8zIcjZ1bjba7FQIas1ggqQ2hGopgrgAraSC2dBfZ+0FwDkTS73WweMZaq6C+3w
         A6qg==
X-Gm-Message-State: AOAM533FmVUct1jU0pOaA8dRzVSiaKQxSuTgwO0OObTCaT9RHwxkMRzz
	8ZDuTvxrshakUlhAJgz30mVETmqwdGnBFA==
X-Google-Smtp-Source: ABdhPJwqyfqh3TdM8rEWKG+tvJdNyCdIntwg0OJn3Jsu+EfLz1PnNkvtFHLVLTje863Tc3rsUCUElQ==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr26005094pjr.62.1653962672535;
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a1b4200b001e2f8163810sm367573pjq.30.2022.05.30.19.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
From: Chengming Zhou <zhouchengming@bytedance.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] mm/damon: remove obsolete comments of kdamond_stop
Date: Tue, 31 May 2022 10:04:21 +0800
Message-Id: <20220531020421.46849-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0f91d13366a4 ("mm/damon: simplify stop mechanism")
delete kdamond_stop and change to use kthread stop mechanism,
these obsolete comments should be removed accordingly.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - explicit termination uses damon_stop() instead of __damon_stop()
---
 include/linux/damon.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c62da31ce4b..2765c7d99beb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -397,7 +397,6 @@ struct damon_callback {
  * detail.
  *
  * @kdamond:		Kernel thread who does the monitoring.
- * @kdamond_stop:	Notifies whether kdamond should stop.
  * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
  *
  * For each monitoring context, one kernel thread for the monitoring is
@@ -406,14 +405,14 @@ struct damon_callback {
  * Once started, the monitoring thread runs until explicitly required to be
  * terminated or every monitoring target is invalid.  The validity of the
  * targets is checked via the &damon_operations.target_valid of @ops.  The
- * termination can also be explicitly requested by writing non-zero to
- * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
- * Therefore, users can know whether the monitoring is ongoing or terminated by
- * reading @kdamond.  Reads and writes to @kdamond and @kdamond_stop from
- * outside of the monitoring thread must be protected by @kdamond_lock.
- *
- * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
- * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ * termination can also be explicitly requested by calling damon_stop().
+ * The thread sets @kdamond to NULL when it terminates. Therefore, users can
+ * know whether the monitoring is ongoing or terminated by reading @kdamond.
+ * Reads and writes to @kdamond from outside of the monitoring thread must
+ * be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
+ * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @callback:	Set of callbacks for monitoring events notifications.
-- 
2.36.1

