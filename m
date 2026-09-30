Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDC36B904
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737691; cv=none; b=hCnpnHVQzMAdIV+/TPLmAjlwDRRn6lWHmAK5eJ/lagZn9Mqnth+Pxrc6TKzDeLxueLbUCxGjaekPm7oULy0yFiyylx8UXCJBYM+wvnAlHSwTCuhqhb1vWsYKXcxThBPwSBKPpxX0QSl2n/qKyyaeoRY2TV7mj5F5vhPzR+zVwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737691; c=relaxed/simple;
	bh=LxSvb3tFEHxN+UPTs1YpJcVKRl8kkg6rttQGBqjpT7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/FzEE55NlGDy26/u1q7HjNDdrdxPfYCgRgNIw/tCnTgX3VsqxCkBddsRbR9SVD/MZWZawbRjs3qS8hGVKSFc5l2Pa0efQFHL05iLLqCcfJeCax0sz1LVzbMgQV6ALK8lwE4e2/Lf2f8CmfIOrzZUX/Fm4iVUbLQHRiED7UKatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn4l9MaM; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn4l9MaM"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so1703887a12.2
        for <damon@lists.linux.dev>; Tue, 29 Sep 2026 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737689; x=1791342489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tADa+gUpKB6hXrMlk4JcdjCrfBHR2QIQ4vRaRu8qGQ0=;
        b=jn4l9MaMwA7JN+56OnT6m10hwsU27RH38ortO2/bdKMM6eX2iHXRyVeWPK4viwnsNh
         j8O7pdfCwfB+0ZI605i3Oqw0+TJaknu96cVdUbtRTfmoQgCtCauHwqGYgrBlCr3eWWRi
         +ReyfF9WeFKOlga0Q0Vkzoq8Ghi+u4aSackA9YeygmnDKmaNszV4+hGi9rdreRef8vdw
         ue2+wkLWjG8+ksuxJQTD7LKO1qhieWq1EycwQML0uuYmjflZmWerXwoPk6ShsxMJKCau
         FhcI4jN2bnLMV6KWeFc1kchCUcPNL0fRiIcQLzFLCMhxzYoSSnTCqxMeaRJawXao63YO
         o0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737689; x=1791342489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tADa+gUpKB6hXrMlk4JcdjCrfBHR2QIQ4vRaRu8qGQ0=;
        b=CU2bFGxJ+ITWY/Opvt+rilTKsbtEFg/3kg6f858f2jmDlo6mFaO7qRlRK5mzo0jq8t
         PiNKFgArklMsTZG1rJuZYu9m11YFuGkkWmtUwQxkMaZrCR3MMcKcBNfYsY8aElAN7QzP
         p1hpy9W63wE2aoLBao2PeYMkMYe/uEwySHEEKU0f1ReP8jc9t+oh3LiRkb6pw8m+wh6A
         2ok2bcFpuG3RtIeChxUaKHh3Qj0gA/AakbaYc/MHjLjZZTcdoc71Eb6i72dDRleefBYH
         LFWVyUa3gjgD4EY9ijusHkyoNplJfIvRHlRzici/miojXnXlIma7vB7KlYIB+/1GJW6R
         e2uQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0gy0WJ9F3CFVUhqlZ5UZo5m8+T2a+eImrRf/CUrFazm3gNzKynPQoQBzZKt+M2nZOgvFUVQ==@lists.linux.dev
X-Gm-Message-State: AFuF++licnBiBxmiPAEdzYkzz9RSDhEbhwL3mvxcfjMjcpln7JUTPRNm
	oT7COXevv+PZWQMi7M2/5PsabXBJGgkyduexP7HIrXIZZVknefP46bh0
X-Gm-Gg: AYBFou2axSY4WpFyifng21u7lyG3YPn2zRY3DENtTInx6qu5CTjxPFS56NYyu3A38aO
	msY7SQOOAcxa1k8MdA0KooICuRxG6MxoIVDJvv9cJHmfEimUqrRwxAlJc9sf7/3YP+fy8ENFV+j
	gjvRqlq3TE6rwIzkzFg/5imtWBPjma4Z1E5kxBCDaD+XzgEtlgVa4wxBJIcoGs+09I35x3Ff6b6
	7/fC1N0YgMzMXGIDrVCul5qBnfHFQgtQDf3Rr1YMEIP6p+BSqFO/sfUKBHvPY48y/AsVE6c/d6/
	lv4q1tnspSd4Um5bFodjmvAKRf+BBqpdXvtGatCOoi+ESBC7alxzEYqJY8M/eXyhwAy5COf8tTu
	qdptbNaYWu+3cyUNzLW/a/QbYLitUayZWOjfJsZRZuyrVkK3FScSDbpp1MpnNdWBWSl65n0aSZh
	TlezHLXGVvzlc0ZdLZGxkJPwNOhv+SlamwXcJR+9sJy0RlYsoX2xKZoopvREoN5vk45BUoACxA+
	z35Mt4BJ9oo7M6NZc+ObuoEAgBA2UNuBOAwLb19
X-Received: by 2002:a05:6a20:a10f:b0:3de:675d:bcec with SMTP id adf61e73a8af0-3de9e844603mr37737637.59.1790737689067;
        Tue, 29 Sep 2026 20:08:09 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88722f72dc5sm101341b3a.3.2026.09.29.20.08.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:08:08 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>,
	Jialiang Huang <huang-jl@deepseek.com>
Cc: lance.yang@linux.dev,
	KunWu Chan <kunwu.chan@gmail.com>,
	baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Wed, 30 Sep 2026 11:07:29 +0800
Message-ID: <20260930030747.47294-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929165603.49436-1-sj@kernel.org>
References: <20260929123241.1408414-1-huang-jl@deepseek.com> <20260929165603.49436-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Tue, 29 Sep 2026 09:56:03 -0700 SJ Park <sj@kernel.org> wrote:

> I agree the reclaim-reporting granularity mismatch could be a room to improve.

Thanks for pointing us back to the Access/Contiguity-aware Memory
Autoscaling proposal. Jialiang's description gives us a useful deployment
context and a concrete problem to investigate.

The guest reclaim/reporting case and our host-side THP/tiering case are
different, but both raise questions about how workload behaviour and
monitoring granularity should guide kernel actions.

KunWu and I would like to help move this work forward together, alongside
the existing DAMON roadmap. For now, I would like to share a few possible
areas for discussion:

1. Workloads, DAMON policies, and tiering. My current work includes
   improving masim-based experiments and studying TPP-inspired memory
   tiering. We would like to make the workloads more representative and
   better understand how DAMON's observations and policy settings affect
   placement decisions. The aim is to understand where configuration
   changes are sufficient and where code changes, if any, would help.

2. Testing and contributing to the existing PMU work. Our initial focus
   would be on helping with the Arm SPE integration and testing the IBS
   and PEBS work on x86, in coordination with the people already working
   on these. The experiments could evaluate whether finer-grained
   sampling provides useful additional information, and at what CPU
   cost. We could leave huge-page-specific mechanisms for a later
   discussion, guided by the results.

3. Following up on the DeepSeek workload. If the team is interested, we
   could learn more about the workloads and tuning questions they can
   share, and study the path from workload behaviour and monitoring
   parameters through reclaim and free-page reporting. Pratyush's
   reporting-delay suggestion adds another useful dimension. This may
   provide a practical starting point for revisiting parts of the
   access/contiguity-aware autoscaling work and evaluating their
   relevance to the reported workload.

Could we discuss whether some of these could become follow-up milestones
in the DAMON discussions at LPC, or here on the mailing list? We would be
happy to help organise the discussion and take on agreed pieces of
testing or development. We would also welcome closer collaboration with
DeepSeek and other interested MM developers, including Muchun, where our
work overlaps.

This is only a brief outline for now. I plan to bring the experimental
results and remaining questions to LPC. After discussing and aligning on
the details there, we plan to share a more detailed proposal with the
community and write up the planned work and experimental findings in
blog posts.

I appreciate how much is already on your schedule. We hope to support
the existing plans and help with agreed tasks as the scope becomes
clearer. There is no urgency to reply; we can discuss these ideas
whenever it fits your schedule.

Thanks,
Lian
