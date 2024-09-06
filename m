Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E18188A31;
	Fri,  6 Sep 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630327; cv=none; b=rRbK1/Va4HyukYYvpCx0n2zUtg2dp/SWSZZp/Z1mKjJaGmpHopayAX4D7snYIp7lNQfFEkl3ipgToVZl70bhup+4u1L9AH1eTWgxS/9iZ3JfHD54iDlqaHCRS0CuPKHpWWDrExsSFXJKsE98LreYMYWaTF0Vk7+eTc6eK72PbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630327; c=relaxed/simple;
	bh=D9mwUNXxC/j5K9uvw5L/WU/SNxAuyrswt76dmUCYKJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqszrZdx31tEzUzc3Ovn3VCC5SZf7H8/Ni8UT3WBzNrf4FcODr4E2dSYt9ubYAVu9IVai/y4W3QLN+Zsd4gZgdPu/GdVq9eZ4ZfUyOuO7WyXqatHeVTCZJqK9Fvm4g8pURaOaqVgXPcv3yBRbxwvhhyo9QsSb6/Me/Rhq5z2fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIn6X0dg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIn6X0dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8895CC4CEC9;
	Fri,  6 Sep 2024 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725630325;
	bh=D9mwUNXxC/j5K9uvw5L/WU/SNxAuyrswt76dmUCYKJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIn6X0dg1+OCbht+1ToTsNTDiFpGWyNc6BimGxj8umIct/EzudGB/vOIscfl9e84k
	 wpRm9e06RYSPFT/bFxhin95DIdl5Z/kLOqvTEI4OGIPWvluEOdHh0Z4c+aHS72rwTU
	 RtgmPB85779ZYVxRAZUrusedoTHobpCjbFgdiLW0mLnfeyH2sC7AqCMeMafwFORxMu
	 GSODvHlvO4Iwlim0VK+jia9FyLmqybffPcSwmJy2mgUgW58NVg//6lZ7IZIKIiXmGk
	 1kiIkG+m3apPISLxrh6fqlq5iVeUguJZdLEVklvens/eZF+sShzLivNRNlxPzeiCSF
	 LH6dzzOxhXvLQ==
Date: Fri, 6 Sep 2024 15:45:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 05/15] timers: Rename sleep_idle_range() to
 sleep_range_idle()
Message-ID: <ZtsHcyjnEu1Ml56C@pavilion.home>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>

Le Wed, Sep 04, 2024 at 03:04:55PM +0200, Anna-Maria Behnsen a écrit :
> sleep_idle_range() is a variant of sleep_range(). Both are using
> sleep_range_state() as a base. To be able to find all the related functions
> in one go, rename it sleep_idle_range() to sleep_range_idle().
> 
> No functional change.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: damon@lists.linux.dev
> Cc: linux-mm@kvack.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
