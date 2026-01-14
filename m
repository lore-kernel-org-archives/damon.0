Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E087313543
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359093; cv=none; b=E6BKnRGGgzM6tv65Ujq2inkV+plqNcIiudLa4S7OU9Fc0FEBwpRux7pP7PbZZ7pMXxtwgVPHuWPgq+UFmL9wJmN/JPFwTM2WgdMdkIH79xfFXaK1TTD/5Bhun0HlE6ju2psqqRAdcN9GArJprrssQ0OJvCRcOezeU+11FhxTGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359093; c=relaxed/simple;
	bh=TQ9qf7bYA4BO/JcL+3MsINrpNeFWmwB3AH5fXBm4h3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdWZ8hEOMnRKvza/dMKnjBEnNRAI/++WmMjnONmZMm9q6q4BFfHcKO75brrygmbKZ80WPjatCUcOZB4q3nmDGyJdTRpv4p0ZT26o0p1/8gchwCRO760AOejoW+zNHIkof6GvJd0r54nMLlj6fCoqW5nsjIb5g2safjbU3jihwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlxoLQi4; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlxoLQi4"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae255ac8bdso3740098eec.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768359091; x=1768963891; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvu8UPfLlwRF96xOboi7Nid/lju0eRs0SRu/ifxBI60=;
        b=GlxoLQi42VjZcCLvtTOj7MRre/ZM3J0rOda1Thu5rzd5RDvR9ZKCyRkttF1eT+io2C
         Rvo2CyLbXBRRwAGCqerqAJ3qN3CF6oBGgpBNE6hTpjYCEyIqkWzMw8FAUmT6Gnh08B0D
         L5cZXMymSf2y8TOnQzkgp8rktq4Vy4tf5x3DWe7Lzy95OQstfcCDyJMjl/v2yaLgn/Jd
         fYSSq51CB+WuadEmD2VG4+KiGz5clAU4Y/d4d2HvPbIc31k73NZ9oH+RQD7cMp+jLjEz
         DlPUoz5TSMi8QWruvUQ5rWzNgUyIw7i1tlnb2uDZU0sOOoDjZ6L+uDoNRGNWCvRHwd+e
         I5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768359091; x=1768963891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvu8UPfLlwRF96xOboi7Nid/lju0eRs0SRu/ifxBI60=;
        b=VMxi/fmwMMz+5n+S/vH2lq68UwntIpBNpac1BGjWopLqCPsvaL61gTStu8miuEHY6k
         1PQJMa9YnJdnpUfFls0Ab1vGlu29sctazS6tIiUSR5x9vAw3mvZR/6H7gg+lUCTwtc1q
         Wq8dOB+fqUpsSJYgpFD4Ec+OOV2RuI2+wuYRXW7ECn6IgThGCTL52QrEIDdXGNJZBTw7
         qGrwrvLxe7yUD9N4zDv43Vs89AfdAbBxbN70pVw3rOTV2IVnpU7WJwbsNLZqIDanLDn2
         /AUKtwjEEQ/kcPfqyk3I29NIaGYp7WwenNLeNvBVJM2dV7Bg+Ht271+5Nsm9pxtP/g9x
         ZlXw==
X-Forwarded-Encrypted: i=1; AJvYcCVVLAO2f4cacXfOH9L6T47gzOKkuMdjQaYlQVEmA9ncxQNxr+BZxvN0CvyBQVf5WhVV8sd+zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0HT0uyyKvN3h/IYSiZHckQQ1Se/3WTiYfg3xGlHNOYZ39AGZM
	a8temNBNFpVNnDRX+pmu6AlR+CgUPOmM6HGZwfBaPi01wShjDh0FY+cl
X-Gm-Gg: AY/fxX69pRb1QWh4tLvSGSWzciYISxaXcS6C86D5Bjkrcj/cjKA6e70LI1qAyv4hqyP
	A5SC4+uSZQtiPP/nG4K42Scd+NTWRLHY4EVMK+5FHAdheGEvn+aA7fAeU0v1MqkUVCrEPTvUcbA
	y9g1soJrlSOhlyDWKyeGdMbhpb/HiNePxBwpagpLBT9DnpJClnAHmkwxFq0Jpr2nVGFWUdmMIIR
	q5DSPt+yL4Ti4aY3RjKaQvf1ZPLKv+bohRnkpi/fyfX4ZGHweUb52SWELAU3oHDSKLRJSarcDWk
	7gRbkRrXkbYh8BPlxeiyKU0u/2y4HBPY8oes+NAm8nV9LFyJ2CNOuGZc9UE63E2GCWeoktEQszL
	vSWLWfsJeWSTUWVphPNI3IHjk39SFDksKruvFJdYjwUlHP67cx6mmdswJszrXpGbnjYE8o4J7z4
	3JLaqXKjjbZjI=
X-Received: by 2002:a05:693c:3104:b0:2ae:5b88:3499 with SMTP id 5a478bee46e88-2b48f6d41b6mr882336eec.37.1768359091038;
        Tue, 13 Jan 2026 18:51:31 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b4549fc8e9sm3001123eec.28.2026.01.13.18.51.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 18:51:30 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 03/11] Docs/mm/damon/design: document DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Wed, 14 Jan 2026 10:51:06 +0800
Message-ID: <20260114025106.81183-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-4-sj@kernel.org>
References: <20260113152717.70459-4-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Update design document for newly added DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
> metrics.  Note that API document is automatically updated by kernel-doc
> comment, and the usage document points to the design document which uses
> keywords same to that for sysfs inputs.  Hence updating only design
> document is sufficient.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Hi SeongJae,

The documentation clearly reflects the definition implemented in patch 1.

Acked-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian
