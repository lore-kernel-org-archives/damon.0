Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F766327A2E
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948936; cv=none; b=k5X65dN8TUptaNlNWEj4F0S5UpJVNG6IxjX0pjrp0CdTlH8ovk9M/d0+M0o3+PIW500LxH2bcJcOy71787uVDe0aDNUKCmL550lcVrT5EQ3NlSQKGis/DsRu4NSh4q8Tn7tMNa98yi+NHuyaSUdSGaVOkIiozI1yBZLV/CMb5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948936; c=relaxed/simple;
	bh=fpkLiRx4peIwEQMVeV0Sr+7DioZoAzUNHpOYmIWDnzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKEadSudsQDB3DDsXUBKbGwk5MN7OfE9BXbLv/a3PM1c20tBVE6jgLtc1OHhDhY6NOY2SCp0DZNwobLOmsj73IG4Ft778V5VUBs/p4Wkb5ZAhPds/9/XTt1738+wDKC00ruM2MprIo7dZo+OasSB9gPWqycXu8QYQuFWIFZ/Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z66jhgS/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z66jhgS/"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-723ad237d1eso39287397b3.1
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757948934; x=1758553734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwFsPBiwikLgXGeg1StWERPB9X7NSPvY1FsUVXJjxOU=;
        b=Z66jhgS/NpOhkX6Mys13QPaJqXYfYvJ5zTi37h8nXEk40eSZzFBXBqY3QRf+ggwhh2
         M2DHNV4vsXl2RDQyDnp2jKhOdtdO1+BZjTNtYwKrz9hKKiqiNtCnK7vi0QsRKT19pxxn
         NF8fMIGMM6Qn2H/yWPi/OU2tpa+trEtW/AoWEKVe0WGL4mB2ZCufPugDY2D/oQOY+l76
         HAx7GbrS2k4AxF9xHjsYNP59ZEASTDUu5wzPqlE2qhA6r2pnPSeJ8aKSmjW95nGiVyLG
         HG3t0a+Ta6Zqf2nQ+D8qYicK4EKyPndoPyZAxbsv25AFtiIRbRi3vr9hU27t5tuhCYhq
         HCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948934; x=1758553734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwFsPBiwikLgXGeg1StWERPB9X7NSPvY1FsUVXJjxOU=;
        b=nmgwsG9lAAcN0DIG3Hkv8omnfTOmyeQU1MtgclmxplFyCNpEAzoR2BTJctcGurdkI3
         XgNYd+p00fjdqVqXykVxJPq6bVc1V1vyyco0WKy4mj0u69aKlW4M/HrcasG/XwQ7Q7Z9
         XZ4qxpgmhFzBSWOylS7J3QSJUGdv+Zvi7pgshk9p3ram6Uoqo/eKHB55g+/eS7k5i8Wf
         w98tuqwrFx/qigZv8WEZKIaq23DMl7CPY+kzFlagvcDNeBLh4kokgDrWN9yE83dhlt9p
         ClWw8Suc7UC1FZQuZ8VxQFA8pf+SIi3KqCxucuPbnrHvOfP9qduEUCe25E7/r5o18r1r
         Yffg==
X-Forwarded-Encrypted: i=1; AJvYcCU4HV3yKgdTNRfqec9SOGVhsWui4XS7BIMs4bp5348kDsw+6D2v9cQljTvC3EpDs8A1GbWRAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwONncvA1/AfXpV7+ZmUXoTb4fkaWGA6gUP6Mgc1hCCpEmO03i
	bMVeVxZmEdZOf716ovLaWB4xR1pDn76uzwHArXsfcV/Ae+6zpCgxnnGF
X-Gm-Gg: ASbGnctdDNe09iTcXWIszEX7bqqTc9JFnK+tvGyQ52IqDJLXAeJ0mzb2Q1tuhTpAAmb
	CYE/LiTpvJm6SQAXIXeUljYywxML5gPo/DgDNTn/yxYWC+6VRrSr1HC3jHoCcytOHgJMeimQBHz
	CYTGBsRuz1I7tQcAVxojOfcEcJNmA1vg/aXjZrdfgIWRky2f+M5gHm9Xob6ExwWl2osYpBGmYs7
	bXpFDWov/Y30DyWSqbZqQa2bDk1ufTV8/dRZTsrP4KnyvXOFnml1MUm+YRy9p+G5fiJEmd1kKdW
	PU72mjfFxs8hA2nSbiZX6VZCfdHwX9/iM4UdQeadAkDm1OzbfI9jNXLpcxt3WSGE3VVZ62NuGSr
	ZV0c4w+vKSWNQhNylKe7t3w02YNKqTKfqRyA475uqJKB8SutxDOfMKFU1L2l7EKHf
X-Google-Smtp-Source: AGHT+IEoCH4/7SidphYGS+MZaTfXIWw2+iqeHbHWYFRR44N5J03EruPqOb3s6H+Eiuaqun0K37I/aQ==
X-Received: by 2002:a05:690c:640e:b0:732:92b7:8b88 with SMTP id 00721157ae682-73292b78edfmr55749467b3.38.1757948933883;
        Mon, 15 Sep 2025 08:08:53 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73453627ddcsm8002397b3.38.2025.09.15.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:08:53 -0700 (PDT)
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
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 08:08:51 -0700
Message-ID: <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:

> Misc fixes and improvements for DAMON that are not critical and
> therefore aims to be merged into Linux 6.18-rc1.
> 
> The first patch improves DAMON's age counting for nr_accesses zero
> to/from non-zero changes.
> 
> The second patch fixes an initial DAMOS apply interval delay issue that
> is not realistic but still could happen on an odd setup.
> 
> The third patch fixes wrongly written code that doesn't cause any real
> problem but could make code review confusing.
> 
> The fourth and the fifth patches update DAMON community meetup
> description and DAMON user-space tool example command for DAMOS usage,
> respectively.
> 
> Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> just DAMON.

Hi SJ,

I was unable to find this sixth patch on the mailing list. Maybe it got dropped
somewhere? : -) 

> Changes from RFC
> (https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
> - The RFC was only for the first patch
> - Rebase and wordsmith the first patch
> - Add a few misc fixes and improvements for 6.18 to the series
> 
> SeongJae Park (6):
>   mm/damon/core: reset age if nr_accesses changes between non-zero and
>     zero
>   mm/damon/core: set effective quota on first charge window
>   mm/damon/lru_sort: use param_ctx correctly
>   Docs/mm/damon/maintainer-profile: update community meetup for
>     reservation requirements
>   Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
>     command
>   MAINTAINERS: rename DAMON section
> 
>  Documentation/admin-guide/mm/damon/start.rst  |  2 +-
>  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
>  MAINTAINERS                                   |  2 +-
>  mm/damon/core.c                               |  7 ++++++-
>  mm/damon/lru_sort.c                           |  2 +-
>  5 files changed, 15 insertions(+), 15 deletions(-)
> 
> 
> base-commit: d245e17d619ea0336d50b0a6c914f5701d1b0e53
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)
