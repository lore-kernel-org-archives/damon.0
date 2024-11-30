Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212848468;
	Sat, 30 Nov 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991614; cv=none; b=Xs31jjPAsLFL+ubfWFNw8d/XX76s7fjHOX8/BUOF5aSFc4wb8opzF5CEqQpB44Ek35fl3oo+IsD/aX8tXeLM1f2Qjjv9HHwszABHIoDKa5Xavqzk1+7Ricfzi6d6ZYOoocgLw0Ks5e8irLVoVAeTQsmDvTBmGxUEbrPNzZOzpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991614; c=relaxed/simple;
	bh=G6cxAoo8aANqBqALY8Yiq6mVLF6A30FZQ+H8hiJuSZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKMknSmJIsBrFvDiJSR7/lpYeA6w0za9sryqQEmWJ5JBCZ5vBsYE/4qzNJRW3NoXvMT/94G/A9cyqGYhhEWvL3ZD9RCqnklUprNjKZm5kpCCb4jt17z5FJit8pulfiRevBbp54zRAzP34i2ZMW6bG6bEgrVzBaLcWBeHOkxhJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw8gVNMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw8gVNMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C0CC4CECC;
	Sat, 30 Nov 2024 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991613;
	bh=G6cxAoo8aANqBqALY8Yiq6mVLF6A30FZQ+H8hiJuSZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw8gVNMipPXnfjvEKB+8Bq3tnUT1DNcq0boVdHO5IzPELjG22a26ekQeTqIVUuMwN
	 Zla+nCzd3DiK4Lyr1uekaZt/X7ScMySII5R+VbeIB3oP51sFYnUIMo54mN7BwHm/mv
	 GiQrD9za4OVYPx/JEMlYjfGK6qWlc0bRNQecLr70bOvHhQOJx3fz2pAZQYvjbHoVef
	 6vDpX8PybcMepZenR5LRrvnBP3O6rFulDoNKrNYJ/DqmFvyDMQPEwy1uKKniW6wxSw
	 z0kiup5QfSBhaPbDSHtL64E5RgczXgdXV0ZQCrmJqbc5YpRGCIoLX9aE2lv7Fm8E6E
	 gBF1Vi30HG3Yw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat reminder for the week of 2024-11-18
Date: Sat, 30 Nov 2024 10:33:30 -0800
Message-Id: <20241130183330.58568-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241115012529.83546-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Thu, 14 Nov 2024 17:25:29 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
> (https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
> for the week of 2024-11-18.
> 
> After the two instances for the week of 2024-11-18, the week of 2024-12-02 was
> originally the next meetings week.  But I have conflicts on the week, so moved
> those one week forward.  Please check the schedule.

This is a reminder of the above meeting reschedule.  We will not have meetings
next week, but a week after.


Thanks,
SJ

[...]
