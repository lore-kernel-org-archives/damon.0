Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3630E83F
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404990; cv=none; b=OHA98KhGkWjmnaGGJF+hHrYjjGsQFvSP5iNYYAu5CW6GfELm65C++X6pJKzm1g3ArpKzwSndFcgRkiKWMMldgXqp74GVcV3I/170jBgBQxu/6P6nVi76cA1ua7VFo/K1mcdw2tX4VWIRZl23DFuC6pRYsdML3YiYGHw3r2Vl5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404990; c=relaxed/simple;
	bh=tXFiPnQ+N9diyHbtBwSGJbqgrfZShFLSp8E13vrYZgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5YiMGfs17AXiIMuOQYAdo9+zOP2f6vvHwgjZSWibarTNKqGYO8+PkPHD/ZHKFn+GduroDHXvLn5YPJ+WQ+ZVuDpoOg7Y7F6ncooqpl56oHiVnPhY7QdIJdeVx6mO0Y/ZH4avtFHJpZQAerMHYfpYQwpOWvL5QCfArGsJmMDTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbP32bIu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbP32bIu"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf433a99so2038952a12.2
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 20:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788404988; x=1789009788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tVEuaDvVYMx3YWb3gYXxXJkBsoqezd6deCcOB4T/m8=;
        b=IbP32bIu/SrdSGjU+58ExRyf85MKSoeTg+Qjv4rMmMbUsC7Z+sTCAG9teR5i8JY5kR
         SseN6Sq6jbjsdCGXryjJf8c8YSV/1UnxllTQZPanCO2D9YzRWpVt5x6rSWoqTgQmvVLO
         CearKAdoaAaMDVSltYm11OoaHs2mH0FitWchqLQhCA+lF9bROFdTDM84QseqjDbgc4Rs
         5PKMnFbVXImUy+TrFY5uOipynta7VZ64lB5AdUB5tEu5gVY1RFctAROCaqzNESbqf/W6
         Knp4m1v4Xp1/Cjq8t0I1H0UTHSY9vI/A6xyTOgFJ0RNmVLxo+f1e0HOtd2RJl/VkWy5m
         2wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788404988; x=1789009788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8tVEuaDvVYMx3YWb3gYXxXJkBsoqezd6deCcOB4T/m8=;
        b=bbkeRGalT4fpYSn7gljK9R2lE6S92yHU7/9r3jS/jwoF+AXsQEo22tcYlTlHr8Q7b+
         rABuF9Mvr1z9emwI8EsrF5nAjXDEpBpxXnbNg+e+LfQJaEUkGMhCvqWONOwJfSx3ScV5
         ScLI2vRJo8mCbf4XFSN+b0cGZtKGSResOsgdVsNxkGJ7ML69RaOcJmrGVCMWmBL/FPsK
         +n8OjeV0zDDSsmFtMBoxh1PMxmtGVEoCDoH9qQZhIDluQYwrqOId8W87WmqQZBaOPFVU
         uTa/AYtfhBfpwLmK2lKhcqBkefQK1q5lPWyEarVR+L51PMK0S/SfpC5JpzlenmkoGXVR
         Ov4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzE8oDjx6aY1ZMaQd4jpPEbmcSmWopjYGZRys9Jasdn1OSIJd+iGXSNF18y3mKFVmHsayZx/g==@lists.linux.dev
X-Gm-Message-State: AFuF++lOcBXJYCv/jVUXVjlSaRvdrh9b7ziWqtMe+YRkgv/X1ZP45i3Z
	LtXgq+8iliRsoC01cKTLZOyk/k3GfwdeJHXHMizBgfwrCUFlGR1gjLm5
X-Gm-Gg: AYBFou29x47zw/AObTFUp1BhOC2Z6iyk13foRkWY1u+sGKKFy2EWlHkxf0LTgZlSvHo
	aolbKCejEXXauVCfwsa+K5Pg700LyAU0UPtxzSsqTVTzJimpnWKg2Eh93xjx6Qwmglb4mFGOl27
	LOuCiyjEE3cSgzB9A45e3jcToCwWWQ1D0eoIuWXd4/kNz8YLmM2Nh2ES9MdDHJM+nde/hwfkXW1
	68FI1ODUZ8VosCcbYeSd7gtwKiqLnhrQz3fVVZl5Huy40n79kzjgXU0yLhexTpoiDhzgzhTnJRG
	/7dSbs5hXJg7U9NfaLEYFEmSeJ3iqbqhP7dVZo4t24H/FAvmlzFaZDjY/1m59O0oS1WrKxWX1Dv
	H0T75X2UOx9yWaOfr2VIUELtV9ledFD8cQaNxKXvSBEc+3AdhTXPMnZB9M/XglmKXFT53cvAT4S
	qv2yU+JXMvt5ptmBwb5e5hD7f55erwKxZRdhX1J3LyAaK8+vfQpoI8OCFX3fk=
X-Received: by 2002:a17:90b:2cc8:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39aedf8b4f9mr15154792a91.2.1788404988029;
        Wed, 02 Sep 2026 20:09:48 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcd243sm2266519a91.5.2026.09.02.20.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:09:47 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 12/12] Docs/ABI/damon: recommend subsystem doc instead of admin-guide
Date: Thu,  3 Sep 2026 11:09:34 +0800
Message-ID: <20260903030939.336002-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-13-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:45 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON ABI doc is recommending DAMON admin-guide for people who are
> willing to know further about DAMON.  Nowadays the subsystem doc
> (Documentation/mm/damon) is a more recommended place for even beginners.
> Recommend the subsystem doc over admin-guide.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-damon | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> index f8d2601e82904..ad21f58f3c912 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -3,7 +3,7 @@ Date:		Mar 2022
>  Contact:	SJ Park <sj@kernel.org>
>  Description:	Interface for Data Access MONitoring (DAMON).  Contains files
>  		for controlling DAMON.  For more details on DAMON itself,
> -		please refer to Documentation/admin-guide/mm/damon/index.rst.
> +		please refer to Documentation/mm/damon/index.rst.
>  
>  What:		/sys/kernel/mm/damon/admin/
>  Date:		Mar 2022
> -- 
> 2.47.3
> 

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

Sent using hkml (https://github.com/sjp38/hackermail)
