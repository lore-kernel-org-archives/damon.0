Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436720262E
	for <damon@lists.linux.dev>; Tue, 12 Nov 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426540; cv=none; b=tUciD7hCFg/OchcATR2Pg2LLpCPnESahY16h2mTRVKuu7rypksXvyhGVMRBVh/5kHV6+pR8il+mK5H/7LKh6xvMjzgEKfdtO1opFyRt1HcKAwNSJYNdORzxL9bWIPq2iROQx0FiMcWnqB+wbhpg2F6MYcUmmRx6Pfs8oj0tXRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426540; c=relaxed/simple;
	bh=40y9JgI5G7vdDFLJMyJwxVs1kJ/Cd4M78LENlbcamGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JCq1htae678sK8edJhLFZTwpgo3a8CAYgQXTBZ1gLkRS29wSRU8bl3d4bSKIqv5KJmVgOcPBeq8gjmMqLgShdchnS4FXXxbV8PBrekELgao2VLyb8sEZ8YHLTTllUZpnLPd+6onzf1NSPx7eQOBkDq63XDf4sJPQzIG/MVnmT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWUzRk5P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWUzRk5P"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cd76c513cso49547455ad.3
        for <damon@lists.linux.dev>; Tue, 12 Nov 2024 07:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731426538; x=1732031338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p948C0QrjbXhA9Hwm5sgEm5mPnJ0vtdxL7YU0iPETlg=;
        b=aWUzRk5P0t0cu/UfeSyALzcydRUeBVVGDQteckW1XGuTRfon/pu5Ll4hyuOeBkyJ3T
         6LwXh9vMgo9XfQTnwP+D/2UyLJI10/PUuytIT5bhalCJPp75ljYnySS5yaXqpNGPAiEc
         VKLnsymQC2vEN5CcxMNs/skPXKvbx3oymVaSYA2HmymTXeEZ9dUsrjE9rV6BXE2SYSG4
         vuswk2FaG6Hg6pyGZgVOh70NDx++4hwBav1t3o+Jrm0A5lFns4rgt26vdZ8dayaAU02X
         n90TI2Mh89+dHa3tTRI34cvgDBqbm4xoJ9LIVkHWNO5xhlMwzktyHNeCRkabG664TgZA
         WVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426538; x=1732031338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p948C0QrjbXhA9Hwm5sgEm5mPnJ0vtdxL7YU0iPETlg=;
        b=xBDlX3qXBWbyOn6wK4lYEeahOmQBuaNqk9VbkEU5XfAGwjuA30dol85OoqGDPmToP+
         beZmupSdy3Cu+ZQKgfWPx900k1crC37yMyMGldT9XPKhkgmm7TjZMzNZ7HhqlzNS+F9O
         jwZs6KobvRMkTyVfxO/Yr/hWeq+Yz7O9oa+jZOXLt5t3Y06/CqpKlHY1h8y470nNtTHv
         u2SjV66b7oJAXBEi66W/orZu01BobsZCD1K5fjWiBW4cDPO2GN0E4VqJbX+DzlF4uAz6
         9w2woOFA4zyd1OPZuwJxac/XX7LsEET5wE0inuF/Rf7lAGW2+r/evCx3/Pyu6JKuYCLc
         RDMQ==
X-Gm-Message-State: AOJu0Yz4z+vZjHCkSiv3oa0aGxJTANw7lcJE3sv1pb9B2R00qOscDg0T
	goqIE5mEtVq0cZyIrdPvR2viEI43Ob+EJH+V0a74yRpVsgnKQYMTbYl1Ww==
X-Google-Smtp-Source: AGHT+IEDe/GWYZeiy2EfqjwJoY80bKauV4ezn1oFKu6k7m4mEwGLf24tBhL1+iBH9VBnFvKgJRVStg==
X-Received: by 2002:a17:902:fa85:b0:20c:e724:6de7 with SMTP id d9443c01a7336-211ab92a1c3mr28143105ad.17.1731426538020;
        Tue, 12 Nov 2024 07:48:58 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:76f9:c667:75fb:abdd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59dfesm95217935ad.181.2024.11.12.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:48:57 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akinobu.mita@gmail.com,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon: fix order of arguments in damos_before_apply tracepoint
Date: Wed, 13 Nov 2024 00:48:28 +0900
Message-Id: <20241112154828.40307-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the order of the scheme_idx and target_idx arguments in TP_ARGS is
reversed, they are stored in the trace record in reverse.

Fixes: c603c630b509 ("mm/damon/core: add a tracepoint for damos apply target regions")
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 23200aabccac..da4bd9fd1162 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -15,7 +15,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 		unsigned int target_idx, struct damon_region *r,
 		unsigned int nr_regions, bool do_trace),
 
-	TP_ARGS(context_idx, target_idx, scheme_idx, r, nr_regions, do_trace),
+	TP_ARGS(context_idx, scheme_idx, target_idx, r, nr_regions, do_trace),
 
 	TP_CONDITION(do_trace),
 
-- 
2.34.1

