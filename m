Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D3033E3
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091984; cv=none; b=ND1nZzC0DaptWPslHkffuOfMpRBfF4sixr+BBXSEjDNEqQcIakexJl1qDCmYVmDGrxoAATwTpUolmtRznXXGfFbckbkTwClqrIWSlmSAoTYhNmpCl1NvuIDoP4EdjsciNAxdNni9i4uyRexA+vRQhBVFHww2dqRcTxbnWss5Nig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091984; c=relaxed/simple;
	bh=pJC3xc0p6+EBlCgz5Bo+NeJ54zH02pxqTnP/Q9umVmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGgHFSczHbzCQLl0yHpbCPZ6/TDNTplf+YxHhTlqiud2jWZ3Ss7TbHFgmh7AofYQTHOFiY1pkTc8QhVt1kmqo5/YglV0Q5ZMNwpH+3oJi3HJ/M+8d4XKmTLbD2wWjnzS1em90jjPzzDfFzR8ruuOPwlu0OChVT7WBLdvcphMEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID08DejS; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID08DejS"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso321318a12.3
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789091982; x=1789696782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWwhsyhtDrdmnn0DmmaTBqIJjC9gQOjB5CQ4+dpEieY=;
        b=ID08DejSmTMeCE/XWa/MSGhfqrxCiyIaYIDx5SXiMvEFEtqWSav2AdnVZEvHA624n4
         bkJlnqPIvyMIhJrvY0YfoFrdVUstCwopwRv5Nv+a7zDTZniah610ViU/VxSClV5jxMw8
         miFluMJyyRwZ7STAMp181BzEyqyAMTH4usvUUw+UGmvAiAX0oWIIP9Mtu/go/uWYwDxp
         rjuouUhQB5Ui/LOJR0yk2W/lUeqH7oAeunWjzds248YfqzbQ0+/mXscP1xbljy3fwBUV
         uPoOGkH1F6wRn31BhZabHLC8gWfvgS0I7WDY5wSsot/TVX6GXjFzpcXdGWGMsFLbBXQ5
         FjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789091982; x=1789696782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWwhsyhtDrdmnn0DmmaTBqIJjC9gQOjB5CQ4+dpEieY=;
        b=kP0HkRYeQk4MwoTUhLwqXBDoNIUX2o5a+vSMFyWNZs3f2kYWwyM1+SV4XxXJ1T3dEJ
         17yEqBSNd4hOjj5RmEwqeFi7Wh7Owb9vZ9ca0aR6/o/Uz/b7rFLGqG7R9FncPr7aFW/M
         MQ+jG6Da7sI1/nMFzoT28wrYWnFkS1aqMZe9GS6vaW17XSDC0noP+HWsr7QDwCZtBgTM
         lMFsUQrn4gp+mb1PZdOzqc8pkthBPi4h/cg66tIRWDBl2j58ZhPv36OyoA+ItJE8bf2j
         bEngy5/F4UhCDDD+QKEg0sBIBZ2I+dEoi2TM8lsmvIu+5qfpvfMwG2I/OFQQEVyxUTjo
         TY9g==
X-Forwarded-Encrypted: i=1; AKwUvBx7TpYB6RKg1ZkoQm7t2QwiyeLeE0RP1qZ7NmG16z4lntSv+PZjJoCSASnwyUZ8Y8Ti1jRlpA==@lists.linux.dev
X-Gm-Message-State: AFuF++mfKfAXfCxp3uaJULtGQHWyh91X1h9l2JwtXiff1ViGbnnpcY60
	VvPMVF/YYjAcy5LBrBOTx8EFjNuo70uqncTPa+fMXq/7+HWoD0mGupVc298O/FFKmnE=
X-Gm-Gg: AYBFou2JB97XybIB386DBvwmvIunbOXcuoLFu5/5StifSgdzDbgiErfz/KWHkM81X3b
	dUEcFZvAQg2B4oBXgqPOO1r0DVdeST+dOGVBba94VQEU1abXofyFFoVva1COwgKIiCWQiWSTyUH
	JUMQ193VbQ1zGXIrDBCmEq1CXo+807J5VcTS7sv3RxW5QHBVJCkKLHsxTyVxDnUa/XCEpqy0YCb
	+CunnT2wDGhQH/Oy6QEy6g7329xn+1YTFpPMBX4yDunmzlDBrQGQsbkEY1MmW1r92T/xEIbF37B
	nq3gZSzM8jldUqQhnAbyA44ErQjunldqdYB+mQ27oZWr6D2sTHVCovIQLoK1LRK8cVTm9AZbigf
	amrrF4EKp3JLhXmfYuxQ9JxSY+M1tJuacnbFePOihgdmJDcTxV2aQhjga4sEk77KRn9Uhm6DdKs
	UqYhMEnafzrdgxT3zWgYXLeRcPcuuxXzYs6bIN7O1BGRtpMOXqbhCCB45ruU4AyqyAXdp3lG39s
	e1pWUFZcfET/qxsuffWE0s7HjXX7LmrHDY33dBQmWI1Lrh6x+I=
X-Received: by 2002:a17:90b:4486:b0:39b:61f1:8032 with SMTP id 98e67ed59e1d1-39d9c2346b9mr2602488a91.16.1789091981922;
        Thu, 10 Sep 2026 18:59:41 -0700 (PDT)
Received: from localhost.localdomain (vmi2317697.contaboserver.net. [85.239.239.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm1777738a91.8.2026.09.10.18.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 18:59:41 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 1/5] mm/damon/vaddr: support prep_probes
Date: Fri, 11 Sep 2026 09:59:20 +0800
Message-ID: <20260911015927.37424-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909140408.104699-2-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org> <20260909140408.104699-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 07:04:03 -0700, SJ Park wrote:
> DAMON virtual address space operation set (vaddr) is not supporting
> prep_probes.  Add the support.

This looks good to me.  Reusing the region's sampling address and the
existing damon_va_mkold() path keeps probe preparation consistent with
vaddr access monitoring.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian
