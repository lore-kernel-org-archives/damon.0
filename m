Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064711B9B40
	for <damon@lists.linux.dev>; Wed, 18 Sep 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669955; cv=none; b=mn0RkwmpyXw49yhCTWr8sTgXC8DMKEL6cPFTE0Q5iD/621Em4q3q4C9O/s8lsF9e/IENIxvvdaBH0Vg1EcB5bxjhqqiwu+hz3ErERDdzhm790Jz1oc46mH64ViM/6N58gR9G9QF/856wCkuoQEetkj+QcQTwBbqXyiHKLuSVmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669955; c=relaxed/simple;
	bh=lRhODyZmWiwBK6GUqKoM+5ZLyovFLI/2J2Iu2ZAXgFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZanFNgtH+ceekAZW0mO8ghOlX2MAm0JpUMYRpAoWAFC2zsn3KGEviFgADwalibR88SvYFFswmSyUjFX1f/wWLxC8lBrgkGs8YtYiyNeSFkvu6sXuolB90NycEVl+zkZQ9DOWCS+6UGcLcwJHmCYIKQigblm6bKvxUCkjXoArxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSYbzx6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSYbzx6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FAAC4CEC2;
	Wed, 18 Sep 2024 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726669954;
	bh=lRhODyZmWiwBK6GUqKoM+5ZLyovFLI/2J2Iu2ZAXgFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSYbzx6wzHyuoXtdpw8X3Si/Q8v0y7lEeZ1ZK53/W8APR2qOEDA9k7pEf2787ePxI
	 w9/vR21cpe8BnbN/2PxHdX/m83vlwUZUDZn1ISC3VRsrfPg0qp43kR7ueAZwXEP/8h
	 NUK7Ej1P+wR6KqvqAn453+Wp1mUWQTGlaQGGrKvxWZ3ZIjNS0gDWwa/Gpmw2kCRtb1
	 mydqZq8PU3Gl0vQfhPdCay/gx3ihvj5sIryoyhsh2JdM96i832CrwUQhKNjxUy7mLX
	 7kxe0ogMGUO//w+zzShCip+rFV+xjseH/k7UFG4mseTF4ETt1pofttSs9Tyc179OJy
	 K3vucV01hQ5UQ==
From: SeongJae Park <sj@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	michel@michel-slm.name,
	damon@lists.linux.dev
Subject: Re: debian/config: add DAMON support for debian kernel
Date: Wed, 18 Sep 2024 07:32:26 -0700
Message-ID: <20240918143227.276940-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <da7345af-1a7f-4480-aa59-153549714229@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunseong,


Sorry, I forgot I didn't send this mail.

On Mon, 16 Sep 2024 08:47:05 +0200 Yunseong Kim <yskelg@gmail.com> wrote:

> Hi,
> 
> This is really exciting news! With DAMON being enabled in the Debian kernel.
> 
> Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172

Yes, this indeed is so exciting news!

[...]
> Thanks to DAMON maintainers Dr. SeongJae and Debian Maintainer Michel,
> 
> and every contributors involved in DAMON and the DAMO user space tool, this achievement has been made possible.
> 
> I'm also very grateful for the reviews from the Debian Linux kernel team, Salvatore and Ben.

I'd also hugely appreciate Michel, Salvatore, and Ben.  Please feel free to let
me know if DAMON makes any trouble, or you find something it could do better on
Debian :)


Thanks,
SJ

> 
> 
> Best regards,
> Yunseong Kim
