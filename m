Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE88F50
	for <damon@lists.linux.dev>; Mon,  3 Oct 2022 06:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5E1C433D6;
	Mon,  3 Oct 2022 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1664778131;
	bh=xWnQqnlkyo17IUJcKzNNtKgQ2UW8Yp2NfjCFo3eykAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWP7Jo0YSPnfR1YjuzW+adwPvPdNlCc/xyYFttu6jQ6vlzq5EzxfEEu+jCre8mEUv
	 hTESVdvJyGzuRAa0JEb9zqeOsItJ/X6rLZi/O2/dDeqpgZ/ydwOFvirOzNFBL4bDwF
	 EmrYCasbRZomPshQmTjxrd1XJ46Odu6Uf78caQWg=
Date: Mon, 3 Oct 2022 08:22:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: stable@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH for-stable-5.19.y] fix possible memleak on
 damon_sysfs_add_target
Message-ID: <Yzp/uo+iKota3Oaz@kroah.com>
References: <20221002225444.70464-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002225444.70464-1-ppbuk5246@gmail.com>

On Mon, Oct 03, 2022 at 07:54:45AM +0900, Levi Yun wrote:
> commit 1c8e2349f2d0 ("damon/sysfs: fix possible memleak on damon_sysfs_add_target") upstream.

Now queued up, thanks,

greg k-h
