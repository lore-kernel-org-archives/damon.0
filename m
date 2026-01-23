Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E9347FFA
	for <damon@lists.linux.dev>; Fri, 23 Jan 2026 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769144275; cv=none; b=Nc0p+t/S2Z/ad0rA1boiAEJiTyUbCD1puN/dN0++IfYQo53dZruSUKb2bY4GQU/XAZzcZI2hoEEEzbwNp98nPHG111yiTGmsiqXcRILN5hwoPIyK02++hehK0dwH1IYT605pYfcSTBc75P7Aok3VBRFi4Mw7m/0T5jWvjAnSKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769144275; c=relaxed/simple;
	bh=gNJCsIARzmkXf+EBb/WlklHpeUg8wMqbpfoVNXrZwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2bTv9J1j/GRkH+lGdaZTj1KvO6g119NH6yPmqAIMRPZ87+7mw8fpsvTXj/EJys1edk21O9BambNi8VUSyb4fnxVr/NWzZsqt9xn2YgOnmFXdF5bZBr4YosaWzNdGnAjtVICctLcLDsAEMaZXSCYzDPxnjEXoXGtzmuGYjVvfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk6Ao0cG; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk6Ao0cG"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fdb90b670so16494587b3.2
        for <damon@lists.linux.dev>; Thu, 22 Jan 2026 20:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769144262; x=1769749062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUE9K2FZw5Ls36EWUpBYNIoEjPdLY+PpGcwmuAyPWmY=;
        b=Kk6Ao0cGPy4kH3WOyRneQXVlstmTUfhNV3I4any2dOqHKKRPh26qwjrmXENfbe3tTh
         5V2GZBcGpygInvMpTFmcBuMza6dZ3h76kkli8YrtWeyc9qnGt5bgZVPesnlba7QLHY8I
         DFRhTZPWjhy2iBxCNikiw7ajl9ByvDslu0Hvgxom7aaT5DQAwnahmhH0FB/5skJeI+v+
         dKNFMEXbik5ILFuoGBkTI3TUsPriTEo0nfUfNEhrnKtERKiqOCDei88rNKqXQVlxLnHg
         pP7Ko6G2/mT50bzEmuutBiX1LJkHYuT/0PxfYD9xCHF7cUkb5GojAYDjv4qNbMOCoZI2
         EpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769144262; x=1769749062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUE9K2FZw5Ls36EWUpBYNIoEjPdLY+PpGcwmuAyPWmY=;
        b=bweDnIi1UOcLnfiUoSIsXm/34c1++ho43cfKzuTzkOf73KMVbtnHCh1j0zGTeLi324
         0/g2YzFNV5qdUNAulwV83GNmaoendJvQRBAs9lFoOkE1oD8VRG7fjqbLfO5ipKUXK5gD
         g7GDoItfjJ2VB2Y7l8SmNgVMnX3a2FSsrOqPycKhWwRuZFbCz5HVgiRT9G1aZwQHAC8/
         mwuB3/AAVDgtylcUDPaQ45xdC9DSHL0m1eqAdUwS8RHgyzBxrVSBHeQlNLLDMxSIUj1G
         sWJlXEYwApJqInsmtY7ORMciEeYeXsASDhB6r74I8nRWe/yzn2iQgh92b/sv1ivWJCt7
         fONA==
X-Gm-Message-State: AOJu0YznyozoTcvq2fYUTW+tdXzy/rJY5jVerHW0jY0tMcQsv99bMxMn
	+swvif4wZogI24/0jezK00UEuhmmWrGiTKBG4+7ZSn+PoB9IkAdbsyaHjluhufQ=
X-Gm-Gg: AZuq6aLQVM4Ur0IYzSP+sUgHzdgPHFiqvUv9SpoupYyVoT/EouWQ+eSG5mPD8C2Sph7
	YejPTe3T6BMpLU9qwFHxFd0w706TpR7ZFhxtw1KlUNVpzvj7eEerbK8hNpyt77lKrPPZ83gUmMS
	iXcSR79mhgzksXRcpD3yi9zkiA1MLN9RnnUpOPrghZYywUE/W1Dj8pLPs60gMJlfPDdDEBg8CCC
	In77tpbfgmXwz/327hud3cISd/ew4xFgv1hLD8YYlNY3scycVsluJvEM6QL5ZMscnZzlGTf9xHX
	/gNfnnoHK9VBR0Ag6U/r0hp5kCD2iK3YeM+dPtvfPOfMe02xhxMQ4QL8xmI27pqNRZ2XMihvb7w
	ltMdX7iiUxDdXU8Y4NYG19aIWeqtFCFT4GmdYGcYvkH6rln2Apb9VRZwJSQP9vp19fGKBJSh0OX
	OXLgIjZ9zzikKmh9XWbJfoKIh1rvbK1h8N+D8E3bzCcqteg7/+O2rEQ7YLiYyhsg==
X-Received: by 2002:a05:690c:39c:b0:794:4c3:65ec with SMTP id 00721157ae682-7943992fbf6mr17105327b3.22.1769144262401;
        Thu, 22 Jan 2026 20:57:42 -0800 (PST)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2b9bfcsm6436687b3.38.2026.01.22.20.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 20:57:42 -0800 (PST)
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
Subject: [RFC PATCH 1/5] mm/damon/core: add DAMOS_QUOTA_NODE_SYS_BP metric
Date: Thu, 22 Jan 2026 20:57:24 -0800
Message-ID: <20260123045733.6954-2-ravis.opensrc@gmail.com>
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

Add a node-scoped "system bp" goal metric for PA-based migration
control.

This metric represents basis points (bp, 1/10,000) for
(scheme-eligible bytes on node nid) / (system total bytes)

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..ec5ed1a217fc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -155,6 +155,7 @@ enum damos_action {
  * @DAMOS_QUOTA_NODE_MEM_FREE_BP:	MemFree ratio of a node.
  * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:	MemUsed ratio of a node for a cgroup.
  * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:	MemFree ratio of a node for a cgroup.
+ * @DAMOS_QUOTA_NODE_SYS_BP:		Scheme-eligible bytes ratio of a node.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -166,6 +167,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_NODE_MEM_FREE_BP,
 	DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+	DAMOS_QUOTA_NODE_SYS_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
-- 
2.43.0

