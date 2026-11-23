Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435162;
	b=KewuqUFLBG6uiELXniig4A+Jrn4TBOcfDyf4V4fouG9UV/ewVKOG3iyFfkvtPpN/XuQB
	 EQYcConolC0Ks5ySDErOcThpdnQlZH9vegwIdvp3ZzmeoHbyhL9xGaa7SPVIxFnODMT6L
	 yCQX7oXGZo4wmVQA1/UPd5tGzA2OQLlVjfJ9WJ+wh6yvV9t1nj2lIB4yivr3izmXc1fej
	 LooR1jPmWGduO53ugxzag24OhW2duyFbly5sHZ18he3/IoDADuv80UIrqDvlBDL7Y4f+g
	 aU+df3Rmyjz64u/xZGA5ARFiNvqfQDaZ9UXFAuZD3InBCpfAbylUXxBL9TFPWJQd4aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dx+aTjtrDDJsLFUH267nfONNl9k9BgtNCWFCXNtAr/U=;
	b=Tw4GuGsi2G1LqzakT2217Op2dLxdOrusZJ37bQ7khN9QCGTPOy+kPD4K611q9IdgmSvv
	 sbqyEiLX1g34pKjC6DSvCYqaFNqkvBwQRxoKuL1JBGgOpi0FvGY1aKTb3UijOY9Wkesby
	 tMywz1jXL/wtoXPv/c/6Qm7hN3uHtsRn3IqVzpaS1IIdzZ/az4+FRGdr3JiiH9BcE4lKE
	 31RHyfuKrIxM2+lTQqcaRDBGq3sEy45DDganTrm7fqajcoYA7HflXip6GJzJoHTin7s5j
	 3Xb7vaIWIAENl79N0UGQNv36mKB81cobU2hDU+6WcepzG47eWPDL0j8pGvWIKo/y5aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=idCk7zFJ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC80606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC80606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=idCk7zFJ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38644aedba1so4654893eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435161; x=1796039961; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dx+aTjtrDDJsLFUH267nfONNl9k9BgtNCWFCXNtAr/U=;
        b=idCk7zFJx8QvmqFjV2VExDHgvI6cNebXih9OxN8M8g3VEcxe7h7niGrKQ0WVRGkROx
         azMK0hlCFOSvCtTuLIFRCgpXdzzLFOKntMvx6uVwx0SXqMdeGDFkSR1wPVVuHz+iJNlx
         /eMp8Yh7K6B5/Rnw5ngA9CeaEGUXLW9PwgBqBZlhue/Xw25zs28tuSp3mx7JltG3o987
         FbHnBsyP6QaJPSaQq+qRXLwXmQyTupuKlTtIXpWvO3PSKccqIkPAgjMS3oBxZGR4JN+r
         DAHVDG3NsigS2hEsGOuRL87pRg2noC9h0ASYR5KFa/0Rf0YuU1XXNCS6XPbrhwEfTjCk
         UsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435161; x=1796039961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dx+aTjtrDDJsLFUH267nfONNl9k9BgtNCWFCXNtAr/U=;
        b=h7BavpZ0ue+raqI8XFkWsaiqtgsB/6y58nU2u0Dh45AqyRTDaqFo3oBEYbvMRFBy4O
         EmXaoNt7EtRHWLuY7TC7sMsUdGKq0lpW+vdv9gzPJsd7E53/q9/NASX2VoeKJ2XWc/YR
         p8xwCVkVMp6AvwzcXalEltjQyhN3x8sUuwiZHOsusTAJ8t78fo0NEFuLn+mnklq45weM
         ibEycjLooqo0NMMSk4rP2UcgPU93mS3SpJB6Hx69BMA+AsMmz1ld9Etvv/6iEe7XUAc5
         WqkyIaTzKM0ScdzfSDC14XaRol0Oguh7UFNCEmBUVaqHSuNEbMrD+JQAPz0jfS7yyd+Z
         He9g==
X-Forwarded-Encrypted: i=1; AL+hErHXxCfMqwr1NMg54WYcmy/WR23M2qG4gxRSgvSXhXYJ54adUMmE2qsGJ50qxHO31ebVM5u75Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9seLR1qgDWK1To1zeRYradFJv4DdP2B900y738m34kr76f3rGb
	uSWZRx7odQba5RCkk1ah2Zj16d0ctlmhbKAkDgfWWQ7ZaouPzlR/Paqg
X-Gm-Gg: AZFdTZdFQYA/A3sTVqjCagNl8He/2itkU98BN+MCIWcwsSjPV7J19a3fOdXI5uB2XiP
	mepjFzHygtiTKA2g/+ElJop6nJR+KjRaKu31+jLULtLc+672SGqag0MEyHgozv1/GOKHgEY8qLV
	ZcuQsDJUHgKg0BhybufVhDbK8/4mzEYib7LsCdXpcV19Cvr+wM2s7tPRu+upKhkCL+VGLoTXuLf
	MOeR4L+GAwPOdsUEcqosM8XswPtOtbi7E2gncgkMEiojESrvNZ42PMxdtPChQxZ8UxCvFiHqs42
	rvn5Q1tY6RO2F6WJGGJMh11nirlURcdb5sm6kcBM0LexYooXC65p2l0b3kzkeq52/r6Yfc9cOPQ
	EjibeV5JB9TUDDYaD8yY/khAABjiPx/DW3xsw/iB97ootvphtBGaD9OSEimz6YcM+8BgwF0kcB6
	PlVqsCDaOLC2Z2qLkwYrTyVWS8id4EiqBARfeIWCgDjh+/XTTzoiVLJyq1CFwA4O3P95czr3i0h
	Q7n1oBOYebLZLDF7p7spSgMb/Cb0s90CPydo0rQSjJaO2QoFGK3rcVwCp4A/ToQXPe04qTDwD9u
	25sKxHf64LSKHbDPgnv41RXXal4CdpjH/ApYSANw05xB7nsC9PL6clu/dX7YS3ZNmLVG8I7gYvn
	KWMRuZgDGfF7zrg==
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr19509eec.32.1795435161414;
        Mon, 23 Nov 2026 03:59:21 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm31590023eec.20.2026.11.23.03.59.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:59:21 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 11/27] Docs/ABI/damon: update for report producer sysfs files
Date: Mon, 23 Nov 2026 19:59:07 +0800
Message-ID: <20261123115913.9026-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-12-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-12-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:55 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON ABI document for the newly added data attribute report
> producer control sysfs files.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
