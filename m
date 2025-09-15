Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C4341AA1
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948827; cv=none; b=XWlqaqaD7RgUDmAxUspxm2rpbBB1OALuxNW3rpbaxM8JOaNzOlUtg/NwNe10yuH7/V+zfJAPdb6eWnP/6oGGjq5R8iHFefhJVFgdEy8ooZ5lCzMfYkeCy+6B27AK51FE897OMK7bURsQw3/GJJtWoaF+v3n+rk5+SSQuNS0AINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948827; c=relaxed/simple;
	bh=mvhyhVaE1NgOtTceXq0ofadHYAv2ARkQsHSzvKbsxAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb5QjQcwZxtRW/MK8Uh+zLmsgGCgtogL9SxtQEBGgogvfFOm5J8LkrDrgjFQ32KTYC0sFM6oQhvaQZdnvSoqVi3HJbqBAFeHvvgZy5H9o+HhQlBcjHWmdE0BNrXLNwMMZBZ/b99tX7gWhltHl3gLYHdRTwtxxzKOI8x2E4SECIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd8FH333; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd8FH333"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-62f9c2df5a3so572907d50.1
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948824; x=1758553624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDVeU4L3YG1TiJ1MEpll75Z/ltEov2CndLJiRR2rTQE=;
        b=Pd8FH333ctolIpBZnM5GfKU88xo/iKCgqrDupI5H9JaBfSEGhIj+5c3NC/BKwkezgz
         mQMdxeN7LZu+BxLOpD3rRSBtwG5qjOl7in4g/D33tQ3XtI0/GRSTx7EYJI9wwu7bIznc
         C3m790k+re9zFhuMw2sVet/CX70mDuWtg/M7ERzKM9Govb7H4btZ+mXSq2dPCXEc3+Rg
         gJk3rkgb7ef9w+rfXaPYuwUeUU+04ib2gguFBWycGXenI1GVxYvLJDXqTkhPu+aeLwpO
         dAdoFGsio4ZmJZXf5U7g9nKk1M1PWUQkthA28zgv3sgo+5oxas/6r7gAmTnYj8tjDSdf
         bFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948824; x=1758553624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDVeU4L3YG1TiJ1MEpll75Z/ltEov2CndLJiRR2rTQE=;
        b=VYrB+PZGIQRulvB9DMl3dXDuCe0HBumB1IcPFDbhBTOxopg1TmrEWbftt1diTk/R0G
         IeZnS4092PwxzvM5FcYpzcg9v8eJ9Gfs8SnGHHoT7Tpni64MUMd2bdlhwecY0Xl3cjVc
         BscY+v+w94/5PRfijpjxaX38E37XVKVYkEIOYANOaXDKoMlDgX3+wDARTJ7bBdJyITkK
         ZwvbDIXcCqv7gkhkF1Dv8dWSuOj6914NsEnDdRR6RkVTvDIEH/txNxZT2j42yHbCckmk
         a/7UZAXkPQ2YuLHQKJ347cl8m3aHIF76zwUbOJSquUc+azEBCCtGUKxe1CXNigoiFCut
         fm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoAAI8uJ3eRI/eoYslTg3Vpoge1bza6atEex3inK3Xaen7Wd6benFQnzJDdY8pQJfORl2ryw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXIVjog9TJyvZpZwzqO3qbk5xH0A0mxS9smSSk+Mz4tNeYz3Sf
	MFKScYWvked+vwLlMLKtlZ7TeoEJBBb7KdZ5pnEGo12T51K1N2McuB0i
X-Gm-Gg: ASbGncuhBGaTYr1vIO0H8nEnelhDocSGCHGhpXBSA3ZfbqeJBAYjVy7hPv7Q5yNUao/
	A8+P/iZ6edEAwupIOjAzvTGqiSPn5+ChMU1ti5Yp6C81VBSWf/G0QnAco4zz9vbotDk95si0QLR
	raSjVULQmrekZAA4Wsf3EEjLdQnU6w+ZVy8H8RpAlAxN9PEi9Ed0npQXPFgVcIk0TgYMNObe/dd
	racRqlL0OVuJsKTsF4pHClPTOdqR7YjgOxOsfO3BNhsyAbLwBYSfR6SmHXpRLBWVUC4y1O2WiE+
	EQx3KtDSwfUixM8aIqPAZ/IpP4JM59AfdFvscRW2AnPEtfsdnZ/g6tpw0P49qNLcCJsm0fW2MlI
	CFTFOlTwaI+t2s28laC7gfWRh5qS6eJ/ixrC1s24Ul5ReQliNcrN50C3bc/7J7Mvv
X-Google-Smtp-Source: AGHT+IH7pt4IX2Xw7+CU3ZHlHQK6hR4lJhRz8r+4QNMMkKKZ9nkGgDixZer0GbSaS8MxEPVoUip+3w==
X-Received: by 2002:a05:690c:3388:b0:721:5b31:54be with SMTP id 00721157ae682-730650e0036mr114848797b3.39.1757948824149;
        Mon, 15 Sep 2025 08:07:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238392sm32913737b3.1.2025.09.15.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:07:03 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Docs/mm/damon/maintainer-profile: update community meetup for reservation requirements
Date: Mon, 15 Sep 2025 08:07:01 -0700
Message-ID: <20250915150702.1499965-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:05 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON community meetup was having two different kinds of meetups:
> reservation required ones and unrequired ones.  Now the reservation
> unrequested one is gone, but the documentation on the maintainer-profile
> is not updated.  Update.

LGTM!
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> index 5cd07905a193..58a3fb3c5762 100644
> --- a/Documentation/mm/damon/maintainer-profile.rst
> +++ b/Documentation/mm/damon/maintainer-profile.rst
> @@ -89,18 +89,13 @@ the maintainer.
>  Community meetup
>  ----------------
>  
> -DAMON community is maintaining two bi-weekly meetup series for community
> -members who prefer synchronous conversations over mails.
> +DAMON community has a bi-weekly meetup series for members who prefer
> +synchronous conversations over mails.  It is for discussions on specific topics
> +between a group of members including the maintainer.  The maintainer shares the
> +available time slots, and attendees should reserve one of those at least 24
> +hours before the time slot, by reaching out to the maintainer.
>  
> -The first one is for any discussion between every community member.  No
> -reservation is needed.
> -
> -The seconds one is for discussions on specific topics between restricted
> -members including the maintainer.  The maintainer shares the available time
> -slots, and attendees should reserve one of those at least 24 hours before the
> -time slot, by reaching out to the maintainer.
> -
> -Schedules and available reservation time slots are available at the Google `doc
> +Schedules and reservation status are available at the Google `doc
>  <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
>  There is also a public Google `calendar
>  <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)
