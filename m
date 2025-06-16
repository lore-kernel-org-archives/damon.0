Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEB11CBA
	for <damon@lists.linux.dev>; Mon, 16 Jun 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109524; cv=none; b=OXYpShtm5q5FTXGk7UuzJJKhV5eb91kmolxoTz+3yrh3kQr9CyvHaXim16wUZZmsss61FcF8hEF+gNc1lEhlSTUcqX/B56vt5b4Yf0sLjo78RLkstD0lUu5SDriLY9+Qfq61MYIkAfYZBuxC5JRklealhPVbdrLHiraR5/IZdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109524; c=relaxed/simple;
	bh=iRkFuMxTZ0h0x2pZI1jYUc7gSmQrpxuVxvVwRlks80U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXZTpqvUKQ1jb/deNlA4BZ96srTRu/+Y5RB1Fv2eqpa/pFadUrpfBoLa16nx26gJ4/+hZS9ySI+wfdoxxxcbZj1rjTA+aQc7q2gMjiAsVYFzCFI2VoVpU3R+HEjqefg9Z0U1WvHbuTiVoJeTyWBN0ANxF0dxdjFDIPxxMtR8FLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIwaXODt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIwaXODt"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso4603319276.1
        for <damon@lists.linux.dev>; Mon, 16 Jun 2025 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750109521; x=1750714321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFlrTdSbiYtSZxGPXOVLI+cEBoyC+FpjHzAjZc+xdGM=;
        b=RIwaXODt5ma/fq664Mt/HEPBajeGxOjtOdfZ1h1PN2KLFxz/4AwfCW43LDcs/5j0TP
         B2pfyzfb91hAWWfKkdxvhaeJNpRH6t6D+QYBGVQO5DMOxtD8rC7WXT098kztbAvDXm45
         NnVWHImDzRDsScqYazhf0fBSLORIYQMvlXMDgOttcLcHZuTKHvwZ8k0AOq0bkPMDs9Hb
         4pduSxywdhYixh7FVKci6NR8H3f3SehpxKUohnTLugt4BTerm8AitTm+gI6gHbPv3683
         JFpCgNDhLvxQd08tGM3k5IlDBjcnVUbp1MVM2flOztP26VNUGnCh0IHtmcxXPFYuYHIQ
         lvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750109521; x=1750714321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFlrTdSbiYtSZxGPXOVLI+cEBoyC+FpjHzAjZc+xdGM=;
        b=cm7nE0EBxZ5nbKtkPQnmOU82tiUdFi72waPKUpe6o2i5gUazMX+u3o3akP7FSKRKJU
         oHih2RKL0FDvxjBBTVa6GHzfk1SJG/cGpwEWFV1h1A8skZNeQTyThBxpYi5lsYksdUjr
         4kLieXg1k3a6Cz9V8w/8ty4zsPsR5hcMaxFY/q4jziXuPB6rTgiYBdLUcijV4e7hM6dZ
         wQhZ21h3se+tLFmm4wZrmiZSiCkOVjcRU17eJ4tsRK0bLnUy/wuFJvwQQBit8AOIyJ/B
         phBj5SSvXQO22coxruzXwhxSAlCMde4yLDL28k3iKj5lTYL3SpU6Ad7TJPacKJeCQFpg
         o2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXUogg/ejIrOh+tvXyyzadwOFdJu2wtvr7+5ruzILJQMz73uewAW1AA0nmHdUYAEPIcyxjNeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaZrYl25Vz/BSckpwTLq2e7ufrxttIZlSwL9i9MQZfECHBzBYk
	IxdQNvua0txFj5oSQrD46N0YUrugWi0le//nuujCTkQEGIsw3nlJYAf4
X-Gm-Gg: ASbGnctvX2uHAuotMymr2QEgaoOwKV3mtiAklTvg4r0TU1CnQPPCY1Li62Q7JqqRwqh
	bRg7yCfB3sCgYsxrmxuwJrsqkBj2vjpBBlblLrmKUEjkokn59SAlFK9/OWB5JvmklpBDzpPihfC
	tqCSpzUvBbn62KAvsS46Cl95lo/MerooJdayDU6mYsYGFSauX32LWO9RbkkCMuI+PghLuc6ihiv
	UNNT16BdyqjKP5lqyxxpeJx2TzI/4DgpfK7CVZZouOhpD0J7TMlDJ7ev1OMODYHz0fBPKbQ1dB/
	aQ1f2DVilL21too9iaS9unRscDs2glufCm46izwMBh3++OEo7RgAydEX+3FApw==
X-Google-Smtp-Source: AGHT+IFTVBWlw9cflhlERZQFd/71VwgIhWWdB/OgezLH02B6Q4VgQCV4eFMJ0bcb9Z0GUl/V8MHJJw==
X-Received: by 2002:a05:6902:2410:b0:e7b:607b:54b7 with SMTP id 3f1490d57ef6-e822acd0934mr14652384276.24.1750109521470;
        Mon, 16 Jun 2025 14:32:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:13::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e09fa44sm3183192276.24.2025.06.16.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:32:01 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm/damon: use alloc_migrate_target() for DAMOS_MIGRATE_{HOT,COLD}
Date: Mon, 16 Jun 2025 14:31:58 -0700
Message-ID: <20250616213159.2839382-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616172346.67659-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Jun 2025 10:23:43 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMOS_MIGRATE_{HOT,COLD} implementation resembles that for demotion, and
> hence the behavior is also similar to that.  But, since those are not
> only for demotion but general migrations, it would be better to match
> with that for move_pages() system call.  Make the implementation and the
> behavior more similar to move_pages() by not setting migration fallback
> nodes, and using alloc_migration_target() instead of
> alloc_migrate_folio().
> 
> alloc_migrate_folio() was renamed from alloc_demote_folio() and been
> non-static function, to let DAMOS_MIGRATE_{HOT,COLD} call it.  As
> alloc_migration_target() is called instead, the renaming and de-static
> changes are no more required but could only make future code readers be
> confused.  Revert the changes, too.

Hi SJ,
I hope you are doing well!

These changes all look good to me. And I agree that changing the behavior
to mimic migration as opposed to demotion might be helpful in making
opportunities for others to use DAMOS as a means to perform other related
works (like [1]), without having to use a "demotion" mechanism for simply
moving pages around.

I do have one question: I'm curious what kinds of changes callers can expect.
Would I be correct in understanding that this is mostly a semantic change
(aside from no longer having a fallback nodemask)? Just want to make sure I
have a correct understanding of your intent was.

In the meantime, feel free to add the following to the series:
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Have a great day!
Joshua

[1] https://lore.kernel.org/all/20250612181330.31236-1-bijan311@gmail.com/

Sent using hkml (https://github.com/sjp38/hackermail)
