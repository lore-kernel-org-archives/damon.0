Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A7259CBD
	for <damon@lists.linux.dev>; Mon,  5 May 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471265; cv=none; b=Hjv6iGxw3qhhjYzVh34bYfVMqzWXS1YLWS+xGD0dNAKoG/iYhH95BFfh/6+fRQkZUViXL47Kj/JgbznBu4kJiS8omYpC4vH6PBt6Tl135PQjfW8oUuNtvZVChyZ4MxWm/aqMQnFdNpAJRODLpMTXFs3X1O6qgSnmsEYTnz5mPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471265; c=relaxed/simple;
	bh=FvQMuhjzacr7SShl8o8TZDo6dX2WouuSeqzJChYTePU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHgGqjvX3fmQX125anj71NL43KmWpgw7I4Pu0/X4LWi4j1WfSxg2Z3fpUghRfWj3DSYwOEBzEDsNDxOjJPP5oih8WeiMTyqqJnX/Kqe6Q7q4JsUFU6CFx56m0PP1iuQfh5pvupWgmcLJeWilHah9/w6+HSSb7y4NapuuqlPEAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKdcfgGW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKdcfgGW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c3407a87aso71523525ad.3
        for <damon@lists.linux.dev>; Mon, 05 May 2025 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746471263; x=1747076063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3S2dYMZ0l+xL65Sj39FMucW3V09fs23H7lhU2APzH4=;
        b=TKdcfgGWUnbcSJQe4OoLYNqm4aITcxf10QUNZCCUJDTdTtrAzQzMWKO3f525Owqep1
         TUu/oztnc3jQ60YD+mv58ss9de6q1zfJtcjvG5JyvIrjQ/UiYFoJEHPbRSfOJ4AnXqU7
         Xk3xbpcukobX3zKd+jWkw4ipMEwXejxlEXAgcaaqf3oxSc7kZGMfBo4MUnobsqThA9OT
         DttT8ExprExJHfsS2jyDPzM9LZD72kUypg+rBeS0QMbvmozRMoVLc6z0k6uwg0PACn1/
         FvDYvQ37PtdR7y87hpPbBU2sqwXRwpaUDX+d5Xl1ENsHnpiHFAzyxWeCeV8sForEiWsx
         AR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746471263; x=1747076063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3S2dYMZ0l+xL65Sj39FMucW3V09fs23H7lhU2APzH4=;
        b=g5tv9ABMCDpSjRQP7tei20CPMOKEASheKyKMiHXF/t3MZBtb+EFNf0j7L3/+yxCzI0
         GMa1+k79WQshD9aqzxVimaatKIV/zbEH1QJxAqu/oKuGqfRX5f6CBittsm5Yz9mEfJHd
         z4C703Kxvi9Ib6HsoASnDZv2DYl2nVUHaUJ78vvesA9pXvElU1VlNTF69cvBmIDZawTl
         dS8QlbpIYN2wkR4dR81g9Z6Wzuyc/83UCggxlltc5hKxPe6KHqgyBwSiJuZZYzHtIqYv
         bFoVXtMQ16B2YLfinfd1c4Yx+PId3hHUnu1ZSVh330+0GaTc3fZAmMIQpTKKwLY7kjmZ
         NNAw==
X-Forwarded-Encrypted: i=1; AJvYcCX0dIwEwo1HlZVyeJfGEkLWl0383yIzucjW/qzthSidZRgq+NWJI1tEN3rD3b9VbzCoyukE5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8Kc1Uu3r13OiI4POn4TemDIUtS5+AtyTmdA0rdDDxTieGsGyq
	/IycbKZQKnHhvoCocAjScmq+2joWLeWqFiM3uAzlPW066qs5WEbY
X-Gm-Gg: ASbGncvvNEOdFE/q1e0QzExBzKTHcAQuR7Wzq37XbxLivBqPTcRI/Cz2kq1LyFcyCKa
	ForxtLVxkWk4sf2LfGNJv2L3H/NbkQlCuQZ3r59LkYRW1HE7hYcWhblMu117U/7TxEOK1obK8wo
	IPc7u7bfe6vm+Fz32qECb2XKl1k0GiiE9DCTRbYXHidCFNIMZZCagAGUcxjHQOYXkpIHlF5MrYt
	0pqKel26r6Ueb3ZPgBK1oXVAJpvt1Y1iGXeaXluDYLmQYlV3ag4qVPvUDSBVYPS7IuXxgdGpkmf
	AzRYYHNY6xSIJTIfYQfdEnqL4q57XEsVXEDHBaiW3baVJZRJCQ==
X-Google-Smtp-Source: AGHT+IGvplLpA/LKq3kGjH3PIjCdiIRIdsSSgAvfr/H5YDVvYNRTxHcfaj2l8/epTjC0qR5f8vQl5Q==
X-Received: by 2002:a17:902:d2d1:b0:224:194c:6942 with SMTP id d9443c01a7336-22e1eaabf6amr127150255ad.34.1746471263029;
        Mon, 05 May 2025 11:54:23 -0700 (PDT)
Received: from Thushi.. ([171.76.81.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9f39sm58784145ad.84.2025.05.05.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:54:22 -0700 (PDT)
From: "Thushara.M.S" <thusharms@gmail.com>
To: corbet@lwn.net,
	sj@kernel.org
Cc: "Thushara.M.S" <thusharms@gmail.com>,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: [PATCH] docs/mm/damon/design: Fix spelling mistake
Date: Mon,  5 May 2025 18:53:46 +0000
Message-ID: <20250505185350.10171-1-thusharms@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word accuracy was misspelled as "accruracy".

Signed-off-by: Thushara.M.S <thusharms@gmail.com>
---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index f12d33749329..700847a7ac9e 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -54,7 +54,7 @@ monitoring are address-space dependent.
 DAMON consolidates these implementations in a layer called DAMON Operations
 Set, and defines the interface between it and the upper layer.  The upper layer
 is dedicated for DAMON's core logics including the mechanism for control of the
-monitoring accruracy and the overhead.
+monitoring accuracy and the overhead.
 
 Hence, DAMON can easily be extended for any address space and/or available
 hardware features by configuring the core logic to use the appropriate
-- 
2.43.0

