Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F307E9
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 06:01:43 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id u27so14349046lfc.9
        for <damon@lists.linux.dev>; Tue, 29 Nov 2022 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dd2bPOSx73YkfI4ietT0CtlJFPAPYcl5w03w++siR3I=;
        b=VueP3BV9DWQDNRdZ4CP4P+VNS3R/j4lV1uV1cXsTBW0u75pHBOhRYGDAUdYvUErmti
         624irIm4wqDMaReKRB30EvyBJ7amP4v+zfVwv2hJUhQyNoe0UAZcezmo2pnlQF6Xrpjh
         yHfvEx6D1DhBe6VCGE43YjmmeA3fyhA58EgzHePnSXxtFGhySFuXaheY0gqwf1leNssp
         YKzzaiR/iVoDS8dyWYp/GGWo6hPAsEsTL9CEXKpkfyfwWcFyvSWVxbos+mMe0ELBlrtr
         BCSxVxIiVT2+ZnQZ3g6aeNXUnk52IIb+bqRn9MbaK0C5Ol58dW3S5HKSmQdCRNC4NppZ
         OF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dd2bPOSx73YkfI4ietT0CtlJFPAPYcl5w03w++siR3I=;
        b=hV+RETTrmZT9ttfBDi2/rq7Z1ihrNGw5g5GBn3ZTZhoUfiwnIHKWP5SBGai2NrwuN7
         g3dT6Spp5MY0gCGTVsdU9hHFnttvySn3LeC0WqOEvXJ4SvzI0F9q0/yZxZ1yejs8i/Gi
         OG/GzAt1mnmhBpL+vJklVLjm6pRE0K9BVKA7KxS8qa+yAB9mXHtZon7GEvWtbiygsHx0
         cGT2ZAX0/AbEweVTDB9NesN5EbXqzkzh+ifk8pd1uqm/RaHI0Kf6KfYHNRwDbeGCLSVn
         6opn7Kzw2XdcIREnGO+UeFGl3gE9q0MDcMe1IYM5ve7yWuII1dRXyVzXmSmulsiAW4mW
         J0+w==
X-Gm-Message-State: ANoB5plqmPyuVutrPZz3kiiXBsCTOd9edYbT9kChKvtYG8p3eRa3awWd
	ktQPB5KjihsfAcwT827SCw3EaSoOJULcVW6fe7I=
X-Google-Smtp-Source: AA0mqf7q7VYdGDYdxOCSlaJ6L0t8HZDI4fhO1M/d/muCK7Hva5Fqezbch6yxwkGj/aDj8LfChdO+7NneUt+SPFcXc28=
X-Received: by 2002:a05:6512:22cf:b0:499:fa38:3da4 with SMTP id
 g15-20020a05651222cf00b00499fa383da4mr19306949lfu.12.1669788101168; Tue, 29
 Nov 2022 22:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 30 Nov 2022 15:01:29 +0900
Message-ID: <CAM7-yPSL2ewn9kjaR01vq8V410G+F1taJzAqVuvNOJOkbX7URw@mail.gmail.com>
Subject: [Question] Should we reuse target when damon's operation changed?
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello SJ.

While I try to use damon, I have some questions whether it is correct
to reuse damon_target structure when damon's operation is changed.

At first, one user set up damon like below.
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/pid_target
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions
    echo 0 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/start
    echo 16384 >
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/end

    echo vaddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
    echo on >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state

And some time pass, user change the operation as "paddr" like below:
    echo paddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
    echo commit >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state

In that situation, the damon_target is reused and the region isn't changed,
former region information which damon_region has -- nr_accesse,
last_nr_accesss, last_sample addr is kept.

But, former accessed information is based on vaddr and changed
accessed information should be based on paddr and it seems the wrong
information to new applied operation.

IIUC, it makes some confusion to kdamond when it merges or splits
regions based on above information.

So, Is it much better to remove the target and region information when
the operation is changed? or should we check whether it's possible to
reuse former access information between former and new operation?

Thanks.

-- 
Best regards,
Levi
