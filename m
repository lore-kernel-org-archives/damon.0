Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28826C3B0
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933352; cv=none; b=Epxd3S/1hsn2+PQWEhT1pXnVogDPjftIr4Y4P/XBo0NZZEAV7yHLnaSBOzqV+NCQT0teaJvO51UNGsdpYIGDeSv3XwVq/xSJ80e15MVPoR7q3yy4/sl731m4OdHyLNe205Lw6cd2GgnpxHug2k9G/VEZJWnPGohrjW9OwBGa688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933352; c=relaxed/simple;
	bh=KMlHZ1xC3+1qBF97/gsnz/xHHgFxmdj8FYcgvWX2MYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te9ow00MzzHoPllcw0qNUkadUa7vkla8i9sLTE7Oy+WXvVbbx632u4U/gH7YPCLBX32F0M01sxhZqd6mtZG0e1IERiLRhQuJz9PqUX+aOLElp2sO5yhb78QvxOcxrRFw6CZIoFCzXqXi8+7aX+ZQsUn3nyZruDcjbbQunJuKJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw09ypaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw09ypaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11309C19423;
	Tue, 31 Mar 2026 05:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774933352;
	bh=KMlHZ1xC3+1qBF97/gsnz/xHHgFxmdj8FYcgvWX2MYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sw09ypaHWUA8uM4PzgO+K/kuvQSK1dnFg+80G3CCrE5s7bN2Z76wdJlQtgHmuHCRS
	 X9p/u2b51sG3KZbmBtlpuV/JL8rJHmxQN9F86ZtaPGOxNugjOAesRAhMCgdq5zAMUQ
	 jO3QBdUBpY/48mUvSRMAoaHliVOwoNSwevRIGiinhm6nuCGonTXuaaolQ8hd9/2Ult
	 Ab+tyCBs5hrrLwQH1wz1RpSlSzRW2946B3quPDRttOWESCtAmTLEYmuEIU2glu4iGe
	 7ekvtKHHadgMz8pOfzPCAc8Oo/VGDScvx8DoPQSAQDgyoOAaXE+NZSd/gLC6LdMh6X
	 lIKg8swQJL0lg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Mon, 30 Mar 2026 22:02:28 -0700
Message-ID: <20260331050229.67637-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330164347.12772-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 00:43:47 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> kdamond does not actively modify the module's
> (DAMON_LRU_SORT/DAMON_RECLAIM) 'enabled' and 'kdamond_pid' after
> exiting. After an unexpected termination, user will still see 'enabled'
> as 'Y' and 'kdamond_pid' as a value other than -1. Furthermore, user
> cannot restart the unexpectedly terminated kdamond by executing 'echo
> Y/N > enabled' again.

Nice catch!

I guess this can easily reproducible?  Sharing detailed reproduction steps
would be nice.

> 
> Solution
> ========
> Introduce a 'thread_status' structure to link the internal kdamond
> state with module parameters ('enabled' and 'kdamond_pid').
> 
> Specifically:
> 1. Extend 'struct damon_ctx' to include pointers to the module's
>    parameters.
> 2. Initialize these pointers in damon_lru_sort_apply_parameters()
>    and damon_reclaim_apply_parameters() to point the respective
>    module variables.
> 3. Implement damon_update_thread_status() to reset 'enabled' to
>    false and 'kdamond_pid' to -1 when the kdamond thread finishes.

This feels too much extension of core API for a problem that can more simply be
fixed.  Can't we detect the unexpected termination of kdamond from the modules
and update the paramter values accordingly?

If we cannot due to a limitation of the DAMON core API, I'd like to extend the
API for letting the caller detects the unexpected termination.

Because this is an RFC and I already have question for the high level
direction, I will skip code level review.


Thanks,
SJ

[...]
