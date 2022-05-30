Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695027A
	for <damon@lists.linux.dev>; Mon, 30 May 2022 02:20:37 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id a13so9092964plh.6
        for <damon@lists.linux.dev>; Sun, 29 May 2022 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSUIiTx06ZERM+GKjNo7mEfUI96cbNfNRpNUyOJxVbw=;
        b=S9dIeOW/SSwI/GwIi6mZhRw0z049GzAk4xXrjDc2cqWoLQTSdpxbVXfo27Q0GIqgZq
         cFIKJFAjhKtARCcqlnJoL8+2P/4uzOZj7N8O+6KO7jEYwmYGj0WccqEJB5lLG5fiheLw
         kciJw4jlRP75b514zThNHbZjytgaPa7TkCW+2RH2WhaxdXOrBmYNIj3Dt3pDKa6aMuuN
         6DxUT6XV+LfRZ3/Av3ieogsztDo17h6OSV/dkUspznWWKQ3fKXNKXPL0VXpCdZwARsdX
         wmI47fH77ypiaOSEYqcwHBc0V9Jv3bWoJjEXfCUaSof2HQTkpb27wySM7+9DQYnqDZbj
         vKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSUIiTx06ZERM+GKjNo7mEfUI96cbNfNRpNUyOJxVbw=;
        b=rVKSZqtvYwZx5gJ89dWVX93Y7SobqFjP4bbTIIjScPz0W3Pf7bCdOsINq9LyLcni/A
         6owjCHxgSmRfuPHX7cAh804CbnIdYo8PtCnnkmIq4pAYsyitrOvZAtnEWYPVUv069WQ7
         DhIb4wWOEPWABOAjy4J9pxo1xRuSQgYohkz6gUor10Y/KM/9ajld5P4l++PYUG0mef1r
         xYOfDtBU9zINaUt2hpzZ5yboOcLX5YrxrnA+Y5UvTEeCpKTKTKPLyk38zvk2iDeT+dVL
         ZHB/m4CvA4n3dsdSRxofzjjp18snuqECUnhTeCNVrV82tCHu+HmACOowMYwXYkN9w3sL
         kHyg==
X-Gm-Message-State: AOAM533AMewnmVzG7hZCBYgT2RYKToYfhAjshHdoczCC8+8LONtwu80C
	Pc4hs+Z9Sv1uEFzGngHvE1RyRQ==
X-Google-Smtp-Source: ABdhPJyyTTZFpomnyQsisyztLTQlc2LMObRARpACojyemYKaITviTQ0rcuZseaH8bYaoKPBMSzsmgg==
X-Received: by 2002:a17:903:41cb:b0:161:dd9c:bed2 with SMTP id u11-20020a17090341cb00b00161dd9cbed2mr52765762ple.138.1653877236645;
        Sun, 29 May 2022 19:20:36 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902868100b0015e8d4eb25fsm4235738plo.169.2022.05.29.19.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 19:20:36 -0700 (PDT)
From: Chengming Zhou <zhouchengming@bytedance.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] mm/damon: remove obsolete comments of kdamond_stop
Date: Mon, 30 May 2022 10:20:16 +0800
Message-Id: <20220530022016.11771-1-zhouchengming@bytedance.com>
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

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/damon.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7c62da31ce4b..fa1c2968b1dd 100644
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
+ * termination can also be explicitly requested by calling __damon_stop().
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

