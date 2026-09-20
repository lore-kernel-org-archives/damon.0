Received: from mail-pj2-f15.google.com (mail-pj2-f15.google.com [74.125.227.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B839734D
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909990; cv=none; b=UvI7dTgtKdzRKIdLX2z7aUvH81byp9ghVzu51VaZrbqf1yNx3HsxnTfuJBcHWXxjO9ujqPeKy14tJ+JnABcvDjGhw+K3hM1cDjjJW3u4qsbGtRdfl40ac/IBab4sSOwKErCXqjyXoKv3AAsJM1M1B8Swkd3ljoC6OagLQNYTd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909990; c=relaxed/simple;
	bh=H/oFXs//cRM+d4MUQBASyHViAbewnwnjMGKsThJUOw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7idr87TpRF+7SoHkklZImVx56NkYnCfXNOCGOFxtaN5lU4mGHGdGO1wayN+SLgCr3M9XvpfEQu2fp3mfVaavqJSDS5bPUDb3JXtqNfOhD3Ao2uNnSg7pmSosHl9EbF9nGDAnT4Ew+aKaq9QDRBjlK77nZrrf+e9UliPZs7oxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euWRgbtE; arc=none smtp.client-ip=74.125.227.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euWRgbtE"
Received: by mail-pj2-f15.google.com with SMTP id d9443c01a7336-2d747f01363so18095865ad.2
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789909984; x=1790514784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PU/+R0zMOo7wyj2oD36GxlHMQyt+r5CHwX5Gco7PteE=;
        b=euWRgbtE2+1uK7ZkdjkjxGCHBOCe+EdRQ8jpeJcYoyQRQJXY/znmIMJMfoUwSorKnk
         +HQE1mp63YhSurI4L29Ey+kWdv0IN7z5koBqbTmTn6XNYpA5zTDM0hOwgPBTjrKJAo8T
         yKF1NuocVL1YJwOkv+FeKUBrAb25RDAwxoFFbryLCjeQao3fSyaDnWG5HEy8QOO7/EXQ
         dXQUOAtyGYZRx9PQHrovdiZoJldCD4Xl4ZBfWImpuJlD/rU60ebHBmhabM2POqikV/WT
         DrkqoalYmuhvc9JxVhPuT4keFKFVsGsVGUjSkBSMoyeNyHKiI3xGXnA6LHvqeR/gUkZD
         mUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789909984; x=1790514784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PU/+R0zMOo7wyj2oD36GxlHMQyt+r5CHwX5Gco7PteE=;
        b=JppUYg7JkqvdUvWv2Z3Akb09uMFXrG3Z7xbagJUYm/xRayQNozbzsf6lfSKUdAKJOQ
         VSiIqHNQGtaw4mBLRopi8eAqLHhKa1YrrYIEc09gnIx37aLEe/edKeMh8EmjbFl3X9Mx
         I0/BWvz0N7ifNY/PPLLlvkpaxSnH5W/xXXAKMvFs1B/aRtA9wbRjnDvGpDPurm6KiBaU
         XjyWN6aTsEmjBubDoxBtBHzEhZRgq/lV4TXHE3BiuHRLWNYMy+2b1wtLeO5uOWyM2DM2
         zu15vQUfrk/0VEI5mBf3ZiiaGITFYW40dYnfEmIuXlVrYlqFK4/1ix674f5Uf+MwQGka
         /JQQ==
X-Gm-Message-State: AFuF++kptj6Dlq5y1gQHX4hCkpOnCz7zqqnpb+orQ9Gi9kOWyam3oSSn
	lSCt0E3CB6ogHnI2Xhwp2fSl0/hdAlQvnmxkz4UolQSHctGkJUWl3nE=
X-Gm-Gg: AYBFou0DREzRg9cSl+o98t/SXNwDfJLHyot8+ZNABvEFO/MmOXYgnILjjFG9cbKdmC8
	N2AEWiMCwrbfIztHvw73JlGmei3UmTA6ADAtu2gFNnCAYIj47UZzNebkUEtI3EvHz6AUgpl7as4
	hjDzIev8mfllph10V8sOY3F8ZTt7VeH0un77DVDi83u3bXpb7E5lBYQ2EeMB6i0b+FoKSvdfOE5
	1dDTtmtEnovz0gpXxeJfE4ProZ4hUAabGaduplLx/fCffwV4GyUOkhzslF75kq64LBwaQLOBPes
	jb3CySrltijWTFicRBthoLH6iVU8NRUQI2+gDvgEshYvFW/CGmv5TLvKmU7dTNGYpM2VRHMRjHl
	v6PGRzMbWywMrucFsYzWvBYgLnfUfIpkRxa87vBoC9fg6ixe+w7Vs5UfBbOB2rJMelWwq1NL16H
	8gzgXANZXpL9d/HDz5AuSKOO/DypgZs/22PZuTATsZHcLuLvRePDtiVCj46onWaQ7XII5T9RprJ
	dzmpHYWkO5AJFTX0jByZSUVzqs=
X-Received: by 2002:a17:903:124c:b0:2dd:ad74:ac84 with SMTP id d9443c01a7336-2ddb1be0d9bmr131483275ad.31.1789909984048;
        Sun, 20 Sep 2026 06:13:04 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm20599695ad.43.2026.09.20.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:13:03 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 22:12:58 +0900
Message-ID: <20260920131258.613770-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920123959.48279-1-sj@kernel.org>
References: <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com> <20260920103714.47722-1-sj@kernel.org> <20260920122430.610257-1-donggeunyoo.kernel@gmail.com> <20260920123959.48279-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 05:39:58 -0700 SJ Park <sj@kernel.org> wrote:
> Don't post a new version without ensuring the discussion on the current version
> is completed.  Also give time for others to chime in.  As a rule of thumbs,
> ensure all questions on the thread are answered, and give at least ~1 day since
> the last comment on the thread before posting a new version.
>
> I will not review the v3.

I did not know.  I will keep it in mind for the next patches.  Thanks.

> So 256 MiB means nothing special, isn't it?  Why you mention it?

I mentioned it because it is a value users are likely to set, and it wraps
to exactly zero, which I thought could be the worst case.  But the problem
is explained well enough without it, so I am dropping it.

> Let's put "The scheme makes no progress ..." before "so it is unlikely ...".

Will do.

> Seems unnecessarily verbose.  I'd suggest keeping only the first sentence.

Will do.

Thanks,
Donggeun
