Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C531AA87
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605363; cv=none; b=Bmnez/FwjrWwtSVJefrQ7C7tjIRtaHIlBg/DU1zK3I+mRujH4vxAY1k1X/Wg0A9UosQmNIcs+UH7GmOtd+Ah2cZ+Snvhr6GU8TxyZJtnaLer6H2SeTN+QVs1jBLgDPtudyEQlwYSKDBYFTCfeA00ULM+fZ+tzEXFINuKNeMOWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605363; c=relaxed/simple;
	bh=uJKa+EA5s7zr0a/1+eXgcUZRVzW4K3hs5659/g48Bl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8DhDmhWuPq0UgGUI70gH/VqmsikAHiUb+2mqPA/Qz70nOr5kyw4bZDu7i5B+1w8WJAPguQj4YcOl2WmPHhKHSLLeA6vyD1cLrRh3UZgdYXxWfr6JFciMe+GAiAXSr/y1NZh4wFQ5Ll0MWNQod7ZyTa7fSI3oUpg4f9p2s7OEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5YrhGy2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5YrhGy2"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso233815a91.0
        for <damon@lists.linux.dev>; Wed, 16 Sep 2026 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605360; x=1790210160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEj2fyxUopAvzTBRoq/IFzzaeRf7xOyxSUgSKR9PaFA=;
        b=U5YrhGy2cIko0IZ/kimPXef11BZgr16/psxSA2fjCwkNUQ2ekZXtpesuvNmeXGCJJR
         Dh/544/JN85r265y9fTqsZqM5PRBuzxBiOGMrgXRu5qRKEaCjJCTT6haYch//LMcfjRw
         LBD2drE+LvlFyBh5KPBZhXmuKOKJ6majaKCfyQ6KxkkcpYeRmG1pjkeRsqfX4uB9X6a2
         JFW2k39z6fQGOX1fOPqASTAvHIxPHKmBWIKkwR7QXsMKd3yW39sZpVYST8/osCRAFsnV
         JyY7sfzaqVL2DPwPbMGzXX6Aaabc6wQAvqJt4NlqUzvV0Iikx+bDsvxqPFoZ30oHSNwu
         Rijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605360; x=1790210160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEj2fyxUopAvzTBRoq/IFzzaeRf7xOyxSUgSKR9PaFA=;
        b=tME9ZeFmpv+KQAv+mZdLM9WoBbADl5or7M9vKjySOKXsDFZO9/+oilfUiOQQugJcHg
         M4hZnJtiouA+WULflPRf3/uHpP2h14YpVcko55MD4ofVA0KvyLBMlxg4ttZrK7SPkZPm
         SVe+ND1fjJp9Jx4zGK72EWOkOWSyXwT9X7jPmDBj7RLSJg+k/ltbybreHcqbZ/hesao/
         BAKex8Tv6BZ66VyGnfb3nPC97AhGEplhtmnwJwDAKmgyF+6jsxp31e5ZkJVwG2+Bl5E7
         ziKnRHWXIJqMIrjuWoihZLpysYeuc0fhTGl7LxAFCqR8P1D0Wjd3PHPt0dPITYAv4Q06
         ku3g==
X-Gm-Message-State: AFuF++mIzm5do5ibAsIKUH3/ismLZ/P3COdsgMEqNHzenHzSHBZ0upX9
	3gDCOhTYdw2VTPfZHm16jk1XeSksFG80UarTENNoqgt8T5QiqWG+AWJTsimjdeNoJg==
X-Gm-Gg: AYBFou1P9IePWIf1+rANX+HZy/4L7Pv//kpFrCwcZ+DXtaWSxwBzjfDVRbREj6M3HPv
	ufzzzArteLu47bjq5X+ntk2n1cFdRu5fkUoog/btebcmDwr0zqm/yujCdFzhXVYhnZAUY/uOGDK
	Ha0i+qSRuxmOr41IgBIigxIgNONycPzdRLI1vY7WrHIhO3zlVxDfh5myurNUf4/CM0DRekOWCV0
	1ZFqaihAa+qX8Tu2yxYlO/dKboYkbR2iYwaueRnPb/nBN6GiFA5ThAIvGBjfmGDTLG87DyPiwTz
	v52yDU1vthYXgXCtIZYHrS6+3OSFSM39kVhzrrJ2shxcYvVkiQMrKd/LVIe3Gf2I5/kfijKobeP
	6LnYW2LPWf3YSIEmxTF2Cgh3QacEjpQsGMe9I5UHYzMQxGpCCV3pRzph20NxfPRL8XPlvlrnZFT
	Ga6xwCQbbFfvL12P1RqflXCrUba9DIg12iTsS6R0xRqe2hnDFWhyW0YYNyqhZhIreCbFwVTw0lP
	cXgDIU6FRLBovFArOQyPfa3Nrg=
X-Received: by 2002:a17:90b:4ad0:b0:39e:3559:12df with SMTP id 98e67ed59e1d1-39e35592079mr3560740a91.1.1789605359950;
        Wed, 16 Sep 2026 17:35:59 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3990:d106:a51f:be7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm1722374a91.3.2026.09.16.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:35:59 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v1 0/2] mm/damon/core: fix the size charged for a filter-trimmed region
Date: Thu, 17 Sep 2026 09:35:51 +0900
Message-ID: <20260917003553.2465523-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An address range DAMOS filter that partially overlaps a monitoring region
splits it, so the scheme action reaches only one side of the boundary.
damos_apply_scheme() reads the region size before that split and never
re-reads it, so the quota charge and schemes/<S>/stats/sz_tried account for
the whole original region.

Patch 1 re-reads the size after the core filters have run.  Patch 2 adds
KUnit coverage for what the function charges and reports, for the trimmed
cases and for the cases that must not change.

Donggeun Yoo (2):
  mm/damon/core: charge only the part of a region the filter left
  mm/damon/tests/core-kunit: test the size charged for a filter-trimmed
    region

 mm/damon/core.c             |   1 +
 mm/damon/tests/core-kunit.h | 316 ++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)


base-commit: 892f5b3b07e5b07f2f29c87750ff94fa58dcab73
-- 
2.53.0

