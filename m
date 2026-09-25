Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66488368D7B
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315907; cv=none; b=Q8hOkr4tgDjtEf46Qhnf8qxQYc9onTA3YkjEdPtI5f67uYLTtWw3H4Z+6l9wJQNpM6gD0BJEk5G1d0xayBNHIPWCIsIj4nLQmxlIen7gxsckzFgse5rfNv5HSYVHGT3AskhsKyTh2glL301sWwr7LDC0iNuskGWc69rpiCyKsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315907; c=relaxed/simple;
	bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI1oSoUp9Bt6NvDRDOOQBvL1hv/6JZK5jo9HRUjImqJEOtl58JJaAv0RHghXFl6H0AYU3xch6K4tbzC0XiCwBCAVwO2q0OQ19N1i2sBGZORTw9OKjxHAGS8zggRmAKbQdi/RSoVhtlZC8OBfZ7suGkErMF+SxVRZ6m4muhv0em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSH6f2Jd; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSH6f2Jd"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso1827305ad.1
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790315906; x=1790920706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
        b=mSH6f2Jdad02+IHxmN12phTaRfpURKXLS/a62qTDAtgNV2Bn2hR+6nqhdmvfJZCaAT
         9nNPnZaR2dGyWZaLz/Gd+jpKx3ksvMYS3v2UyDtlxLJkXn0/fSA9ghJzDsSNnwlL5/ib
         77mPJKsuZ9vbJYGVSbB8Y9tPi47wHMA67lEq8POT5FZTX2imTqff5fEhXfpJkbEvxlIG
         wTx+trX9kH/oQ7rqnpP3gN8khJbYLPYkPA7PR1Le1sljdn6JcQ5QUEQImMNcuIvhEFV7
         rMXoSrkPbzCp/Wm1YAO4gZWXLpnRDgNvG/ztedCcwtspE5mjn71JdIeGxTCMlkHol3SX
         a/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790315906; x=1790920706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
        b=EIUJl0jpnE+85AgoeKHEN7z9LxQUKel7h3tce3c4EOZNUi3jk2GVuvN7bZ+Wsm35vl
         XY7BbttwUy68R+1TDTPsfcLdWaLmKDgLLTZdgcV0Ub0QR4iSsdlLvgM1zmpaO4bO7b4Q
         Ku2tqS3Pp4K4nWgD2pFJhfhSIC7grT4JV6J4LbQdtoJj4o6msMGFJklSaRo3ueTNLIa6
         XoEuz9C4MgOf/JTFzuqY7WRqWckbPzLlRKvcMOvozTpvORAGAPSVsAdjzS4CvTyZCQyN
         tZOI6xUDfuv01N6fQCoWJZtd5qpjT0S3+4PAwKOzaWTkO9JRxvAlv9SNJPZJKdO4oCPz
         jZfw==
X-Forwarded-Encrypted: i=1; AKwUvByfWaQ12f5JHtxA3nDpCXPgnBRa+GBDosDH+UuOY2X740s4cT7wPPBquV9UU0EmJqcNgXiCjw==@lists.linux.dev
X-Gm-Message-State: AFuF++lYj+A4fJMPek/Ri+YMXRGkovaerH/3QFR7L6HUAEju0lySadfd
	kVTNxP95H8nRofz+0KPAIqlO7ivbalGW05RrqikYBDI7CWiUTjsNHHtB
X-Gm-Gg: AYBFou1McytZ2TNvZ5FfpUx5kDyE+5ryUOWhVlWOiqrslqsJeVwJPudQFpqqkmg31xF
	2qHm8wF3fP+g+3q0+YXibjU8LzTB2LHfAcSuXccvbUUfp0dnI59JfqFpIFcdYo4F1xkx6JfsWHM
	Ap3ziPtc+emNq3CsgP8nPfktLblX7J/rADKHikjc14St2KhXqw5Qjbs0U17Z2frXr3QPBrp756A
	dNDhCQGx22utUAx/aWBR+6S8F4sEJ9duYnJm3/PG5/o1ySUxp+sdUVeOotduj8s6W69IXWoWdJp
	nl/U/KqjDqtwYQeWUIb2tZa6PIH2PWPXdesdqRdnRGgEi45NGwdZ1hvj5ck1e6I2fzjO0WysaY1
	G3/ED61jET/bGGOOJx4F4QKmeGwFUs+dqMqC5S9+1O/fUwXP+UpTeStislwslB73vbmz/nM5u4E
	T5NB0TbjBe9xtxf/2o4wc+XxDLsSv8y5HmE9h9asTZM6G/8mWKdmGe6WR/dsLTMsySx278RJ97t
	6DQMmfiG2Dc43BLuorcAMkmjqfvqtY6FXbsX3sE
X-Received: by 2002:a17:903:1987:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2df7da68a41mr37782425ad.0.1790315905645;
        Thu, 24 Sep 2026 22:58:25 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9143cce5sm4734955ad.54.2026.09.24.22.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 22:58:25 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: sj@kernel.org,
	mst@redhat.com,
	david@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Kairui Song <ryncsn@gmail.com>,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 13:57:49 +0800
Message-ID: <20260925055807.32678-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925054408.10431-1-lance.yang@linux.dev>
References: <20260925054408.10431-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

Thank you very much for sharing this and for your interest in the related
work. It is great to see DAMON and virtio-balloon being used together in
another real, large-scale system.

One scenario we have recently been studying came from Sangfor. In a KVM/QEMU
deployment with guest memory backed by shared tmpfs and host THP enabled,
host-side DAMON can report a much larger hot-memory proportion than the
guest's fine-grained activity suggests. The related discussion is here:

https://lore.kernel.org/all/20260915025514.2434-1-lianux.mm@gmail.com/

We are preparing more complete experiments and improvements around this
scenario, and we plan to discuss it in more depth at LPC.

I am still actively running experiments based in part on SJ's earlier
introductions and our discussions. After LPC, we hope to share results on a
more regular basis, together with discussion outcomes and reports from more
scenarios. I believe DAMON will continue to become even better as these users
and perspectives come together.

I am also contacting the authors of the DeepSeek paper to learn more about
their setup and experience. We hope they can join the discussion so that we
can work together to improve this area further.

Kairui is also very interested in this DAMON use case and may already have
discussed related ideas with SJ, so I have kept him in Cc.

Thank you again, Lance, and thanks everyone!

Best,
Lian

On Fri, 25 Sep 2026 13:44:08 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
> and virtio-balloon:
>
> And it worked: time-integrated host memory use fell by 21.2%, while peak
> usage stayed about the same, with no significant CPU overhead.
