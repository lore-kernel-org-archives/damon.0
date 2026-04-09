Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090C2BEC43;
	Thu,  9 Apr 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743580; cv=none; b=LZDaVDyH9tLkB+7SjByO3NT3DVVje8TBubouYPo/ayGDsREhQHFtUjPFNkAiCdZBxYZ/K2miSWR0zas7SwLCTKL7F/vPg0wsttA1ZhV2egp3Pxi9Krt1WfwTBRtH8COXaEn+Lfp0Luu3RQZsRCdmoeOIkrxewUkA5ijArFr/s9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743580; c=relaxed/simple;
	bh=jBPfiBPxlm2WM1isURI2mqe0QeK/tVgNp/mgGBiaY/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VT85od/zWtf0uQ/HHwZV59KsgUxiLq+QdMFbni8PnB345cjDoQPnHQ2hI3pMi6HGoJ0iNlZLbrHFc8Jzr/jLJE6pOqHVLqWYJJwDZVP9EZrYn7GXGwCUd8IaTJQtk7lfYBOuGNB+XjxZ9XJmnkRj2i9Vgh3zQ8U+TbXDKmMKqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6x9MLQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6x9MLQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0FEC4CEF7;
	Thu,  9 Apr 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775743579;
	bh=jBPfiBPxlm2WM1isURI2mqe0QeK/tVgNp/mgGBiaY/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6x9MLQ7cjeA2A6vdamXXAogq9IJ/vOhVwDB5AQhhNrQ3AAfsquP3Z3H+BA156lAF
	 0vwfVwtusDKhYcxIPc/jL6PTGrDyOLWUe5roveoWvL96NSlZ403TecgriRxnHwYbtS
	 LuP2mc9lkBWCUA+t0Pn+DvpcpOEjW2s9WPCmoaKMYKBNz1qPrYd3DBEpjx8Rg5HPrB
	 3bBz3V5KULZ/h8vfvVovwfyV40m5bo7LlMfbAVJIoOw/Yzww3632Aq33ST9HmopgAF
	 HJOZ7Ed0mSl64Qxieuwm9mBu3XbOTHiCVp4Bt8BGrG6NYEIrY7Fr0HAlVV5EZxbijt
	 /YX4dklSo4i1A==
From: SeongJae Park <sj@kernel.org>
To: "linruifeng (A)" <linruifeng4@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	chenjun102@huawei.com,
	tongtiangen@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: support freeze kdamond
Date: Thu,  9 Apr 2026 07:06:08 -0700
Message-ID: <20260409140609.59881-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1b340c6e-4e21-42c3-a1b1-d07813b8b8b7@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 9 Apr 2026 15:20:10 +0800 "linruifeng (A)" <linruifeng4@huawei.com> wrote:

> Hello SJ，
> 
> Thank you for your reply. Based on my current knowledge, I think this can be
> described from three aspects:
> 
> 1、kdamond monitors physical/virtual addresses and performs certain 
> actions based
> on the monitoring results to improve system/process efficiency. When the 
> system
> undergoes suspend/resume, most user-space processes are in a suspended 
> state.
> kdamond may therefore perform operations such as PAGEOUT / 
> MADV_NOHUGEPAGE, but
> these are not true data monitoring results. This may cause changes in 
> the efficiency
> of certain processes after system resume. Therefore, I believe that 
> continuing to
> run kdamond during suspend is meaningless and may even have negative 
> effects.
> 
> 2、When performing hibernate, most of the used memory in the system is 
> swapped out to
> disk. When memory is large, this is time-consuming. If kdamond does not 
> sleep, it may
> affect hibernate efficiency.

Sounds making sense, but I'm failing at finding some specific problematic case
and expecting the real impact.  Can you share a concrete problematic scenario
example with an expectation of the impact?  Also, is this just a theoretical
concern?  Or, a real issue that you find from your real DAMON use case?  If
this is finding from a real use case, could you addd more details about the
observation?

> 
> 3、As discussed in [1]:

Seems you forgot adding a link?

> "The principal reason is to prevent filesystems 
> from being damaged
> after hibernation. At the moment we have no simple means of 
> checkpointing filesystems, so if
> there are any modifications made to filesystem data and/or metadata on 
> disks, we cannot bring
> them back to the state from before the modifications. At the same time 
> each hibernation image
> contains some filesystem-related information that must be consistent 
> with the state of the on
> disk data and metadata after the system memory state has been restored 
> from the image (otherwise
> the filesystems will be damaged in a nasty way, usually making them 
> almost impossible to repair).
> We therefore freeze tasks that might cause the on-disk filesystems' data 
> and metadata to be modified
> after the hibernation image has been created and before the system is 
> finally powered off. The majority
> of these are user space processes, but if any of the kernel threads may 
> cause something like this to
> happen, they have to be freezable." During suspend/resume, processes 
> involving I/O operations should
> be frozen.

But what file system changes DAMON could make?  Could you please add more
detailed scenarios and expectation or observation of the impact?

> 
> Based on the above reasons, I believe it is reasonable to support 
> freezing kdamond. If there are any
> errors in my thinking, please point them out.

I feel like it is reasonable but I'd love it more if there are more concrete
examples and/or observations that support this.


Thanks,
SJ

[...]
