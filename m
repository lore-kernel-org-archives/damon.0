Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B326158B
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023689; cv=none; b=DgkBVJSQ6Y/StgyyGNVeKhs1p40UF9moCHpJdqsylJ3zgRZx3oD0ubEGzake3aE6/e2pqa/1slEpm7fuEql5Ky5raK8P85IKC6ypXA4amMRtgPKbjWcBi0LZDfrjFkknVuAwSzI3wosgR8zklXmeajq7xiQTX0wZeApN+TyWlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023689; c=relaxed/simple;
	bh=/eGV/1xbIJhwm6XIn7cfQH/SY3x1TXbIwB1K2JCBqls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg5URuOLa7HbFbzCzsD9lohm8AWoxVMWD6kNs5LnylUrkmJK7q3CBl8Z8LLvcN6tFhZc7bB+u/89pPUqQ5G4yyRaJs3rKhEJD3/3+0A0fsb1CsZo/50Nxfyit8uvr/nEACelUh/2fzEprqxjvlf7dw6/Jk05+ZU7XWiqVu+5fig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmDbQIEz; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmDbQIEz"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so6636605eec.1
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023687; x=1773628487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEBd1cs2oe7i2LMTBttxBgMKfH6i4xUsDVFq4wSxJlE=;
        b=cmDbQIEzdWmKeHborZJ8IENbrDmrLfBZPTm1S/qHzzIXg1nqYBuE3azgKFeOygWEoe
         aCIAmsHsFjyJMbVqo0ptdnp30JUNSKD43LCOVWTYbeU97hljJxKg7d2CyWkJaWH0gS+w
         W0sktpgkrrJMBA+MB14eCq8MYfj+LR/NJMCp2bQBWO7tqKQuTf54DAh7dymbAyaptoiS
         GhEoqlV4+egfLcTlGDtv36sYNEySK5ldgPJ5uHRoYqwdeVbmrB8A3b58QZSUcvBQPIfu
         CG7stRJuO976ACgLB7i450wWh5uWOHXxzNAQYyDY5tupgYhlCYedH8I9orihHVcdL2LY
         ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023687; x=1773628487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEBd1cs2oe7i2LMTBttxBgMKfH6i4xUsDVFq4wSxJlE=;
        b=lYYpR9atSuOc3Sdwr/os8cAl4SIDz5qJr81TEyjJrFHXCXstkfo3mqy5ovUMOv5sU0
         Mau2bZgGz/KNNP5wgoh8hrUc43WipwBtL3/W++8szbCjMsNQGyDtSVOdmCXO0HyaDiN4
         fmdPO7r3hVF31tPVQ/E82rgtY9fHSBkWmNPzVJZyPc+2nIhxuSMeoEHjZm+jMMSaZP0b
         UldZLtJ+V9PV/2GaTnrKb5thL+EkyGq6CNTKE0HHqDMsu5gEk5+VHv0VInZYeIk3stnM
         wmfSFyl8oqc3h8wgrXEHTHH1+nW7J1Q+pcEVy5BHzuLjBH2HWYoL7cp7nkairVs759T3
         xqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlvbLOxP8WytNGxXU85l6lA0nUAbIr5jBW1r0Y/1G+TCKxO2YW4scZnEoqND7gFrg/PXxu3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1A+gFZCldKEN5LI9SrL5Uv+nritDu4xUr2SY/EqjZUsg29lHI
	0zB/FoVG9ljJW1GAPJla6uziyJu0uVvkAIh3gylNSagdBAjOt/C8PaIW
X-Gm-Gg: ATEYQzzBukuhwS9SaLu4EnnDRfkPmrIsoRIweL/zf/Excbk9tPqQu6H2YSbRHKVnBSi
	MafFlmsSp9W4qnLkga2OHa/jqjz/6MX8QxoThUxnnrUQ844evqmop247JK7YaDTfrildaa/2Q3w
	iNKfxzEGZmDKwBAODitKYtTGTw0JwsZk0iNiRyQ6ZudlbtiQaRdDkiW9RhqvQboQwGL1iQgUak2
	BsapzZD2aMTKVyCQjhS0CW+8Wb219yOTcokdoeiR+GdK2OqSBb3q7qsaIvKITF/ZEHDLFfmbXJV
	bihXenudaGXCbEm5ELdTWlY9m2ravIk0JXt5S9I4qw3gAIXWdRs12iSPwlRf3PZeQ63XFMXrq24
	trBUCB0ujE+03JFrJHoeb05xZzwkBzxPJHdqIju0IjHTDfi/zWM79JxXex1rv2sr5re6OWyP169
	zkegsg3rDMMZtS1k3i4WLy3McMLPmuM654dUU=
X-Received: by 2002:a05:7301:3d1a:b0:2be:fe8:8aff with SMTP id 5a478bee46e88-2be4e03b3ebmr4076299eec.18.1773023686622;
        Sun, 08 Mar 2026 19:34:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.165.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm7076193eec.3.2026.03.08.19.34.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 19:34:46 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	damon@lists.linux.dev,
	davidgow@google.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 2/7] mm/damon/tests/core-kunit: add a test for damon_is_last_region()
Date: Mon,  9 Mar 2026 10:34:06 +0800
Message-ID: <20260309023406.9784-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307195356.203753-3-sj@kernel.org>
References: <20260307195356.203753-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> There was a bug [1] in damon_is_last_region().  Add a kunit test to not
> reintroduce the bug.

> [1] https://lore.kernel.org/20260114152049.99727-1-sj@kernel.org/

> Signed-off-by: SeongJae Park <sj@kernel.org>

Hi SeongJae,

I've been following the previous discussion regarding the bug in
damon_is_last_region() where the arguments of list_is_last() were
accidentally swapped.

I have verified this patch by running the KUnit tests on my arm64 native
environment. The damon_test_is_last_region test case passed as expected,
confirming that the fix is robust and the regression is effectively
prevented.

Tested-by: wang lian <lianux.mm@gmail.com>
Reviewed-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
