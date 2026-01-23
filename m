Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEF2C1590
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144281; cv=none; b=LoHuXsyZK0+ksWk9Zc+4IRBmyqKXiFJpqnQRCNxWqT0dwIY6W6W0M5FZoGJpZE7NJUxWwv1btekgVY5G+XrD/7BL5U5vos7/sDDyTeY7+q+JVD42zJQlI7NhBORQr8PQdfxoBAlfgVjRDMIps/2hS/UnlgT3EeFKO0HRzUQ1IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144281; c=relaxed/simple;
	bh=uSGUjxT6vDYwFOxXkjkFU0pbIbdjzCnzKu1CcO3NxY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDxo7Hnm5HTr9ou3Yibd+jmGyT1KZI5TNxsfzd5iiYVibTOGzVz6/wlExsUAWV3Qp+KdUaNi5kIkO6s3yFMy8sqywu6/ClLNusyRC3fYxZ0zraS0lCTZIENlYAhdK8zPhda0mE7HU9zePITsA9E0zj+qqUtr9XmY95yvYAMsWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IntUi0cc; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IntUi0cc"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64959e30705so845752d50.1
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144269; x=1769749069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ4usUMGfNo7J4lew0QKMfQ7VuYcLUlFI2hm5aH3MjE=;
        b=IntUi0cc32aloJ1jsMNdcG7WYwNnr+4Apu1DPS2j8faD57JgfTXaDzmDZE53koqDdO
         0KlDA5v/nErKlt7GR2fXXHvfmOpi+WAnLk6AyXAr59dT2FQgA/cSTHwj0YToGyZPMZI3
         68seWoG2HJ+vSbUhypD1b8aSffolR/B7xcNS9wob2/T11SC1qCHAv5BVEfNmmq9ZGuKY
         7AbV2mifuJS7kIyaJpb+uZ6f+wivXCwkDjQQtqv8vd/Y2nL5WBEW4Hv9VbB9kL/OCK0l
         1fmCgrNiqhnGrBEerLofElox80Ywzz/pnejiotJBd5NPA5wY4jeZ4zxC/073mvjLO/KD
         HNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144269; x=1769749069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ4usUMGfNo7J4lew0QKMfQ7VuYcLUlFI2hm5aH3MjE=;
        b=h23J4kSghrJjzxFkD/eD/IC2Leu5vFItP7SsONP+p7tyUXA6iOq6RJ+uEeuEMwHCCb
         wmFuWYgBLaT8oSO8Yqnsw3JN8tVVuB2JSMWnVCW0hx9d5U+syPbTtR5So1odOqmckMPJ
         BU63rpfszI+f6CC5DosCiYR1jw3o4qKmo2trEBTKeATviNlxpg1KypHQm/VRZUpliO4W
         Y13bTsmvjb5v1Kt/WTMEzHA8WMUbnnLKTpxIN9AyymZYlFbTYHapdFhiUkOx+YzlkyPd
         VBQCdEktTWZkJSAITM/7RNZ6htQtTnbEdvZqEkZhOO4/1Cx5iHt/gSa6bvk0cLXJVqAb
         HUAw==
X-Gm-Message-State: AOJu0YyKX7cIX5a+MHDauLLRxn1CZ3o9GJ11id9MW81jAGC7fjEqYlEy
	ke2aOwvIa9LPkIipDgqdzT0mj3lU3tD6byZz2udaiZcL96f/fjKXOBrU1ELWkuo=
X-Gm-Gg: AZuq6aIRAioC1R54LmIZELU9GDM+lnu/jSqweAuZEZfN+O7TzuxGo2V2QRsOneKMw/p
	sLP2iMu1GhvajWGT0SDnfp5FtAlkzFm3BH+DJjNKRIgQQl6g2KpHVTBnQsiDOHpGmJVLY+NOlzO
	YzNzXLwxXt4CmO8CO09U8lnPfzbCtIypc0+HwSpUsq57kwkzi/RQ1d+kFpAhrY4xY/Ix9cyQlQH
	W2MrzLkYg3qzQTsMnKV6RgXjDMbhzwxsFyx+b7nPfcX9zOGc+UHhu9MZkSfp/RbC39LFxtxZZ8Z
	0d1PiB+F21EnqWYaj/+P0OJEb02mmcS1P0nle1rRHtTnsrb64HJnq436f1mc2EoAuLstlL4Vb7G
	SLW15q0ORGBR4QGggLmpIybQtxWAE70PKb8SUc9CkBtH0jcvJiE0MPgka1lkn+KoPWeMpfY5JY9
	OrCQ/Bh3DJSjh4o3/IieP7y7H0OWx9npIq3OcR/UDj3aCNBeFPL9CTEbhIJ+lOIw==
X-Received: by 2002:a05:690c:9693:b0:786:5afa:375c with SMTP id 00721157ae682-79439a09235mr29912047b3.67.1769144269171;
        Thu, 22 Jan 2026 20:57:49 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af14427sm6466517b3.12.2026.01.22.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:48 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH 5/5] mm/damon/sysfs-schemes: accept "node_sys_bp" in goal's target_metric
Date: Thu, 22 Jan 2026 20:57:28 -0800
Message-ID: <20260123045733.6954-6-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123045733.6954-1-ravis.opensrc@gmail.com>
References: <20260123045733.6954-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to select the new goal metric "node_sys_bp" by writing
it to goals/<G>/target_metric. Also set goal->nid for this metric when
committing goals from sysfs to the running schemes.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs-schemes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3a699dcd5a7f..37cd5d715821 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1038,6 +1038,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 		.name = "node_memcg_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_SYS_BP,
+		.name = "node_sys_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2566,6 +2570,9 @@ static int damos_sysfs_add_quota_score(
 			}
 			goal->nid = sysfs_goal->nid;
 			break;
+		case DAMOS_QUOTA_NODE_SYS_BP:
+			goal->nid = sysfs_goal->nid;
+			break;
 		default:
 			break;
 		}
-- 
2.43.0

