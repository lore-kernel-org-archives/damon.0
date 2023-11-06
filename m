Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256629CF6;
	Mon,  6 Nov 2023 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC5N4dGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F79C433C8;
	Mon,  6 Nov 2023 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699303779;
	bh=1ojN924qEHttCwp4v9QEGZRz/p6BrttrFZ8fMDi8jpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bC5N4dGm7TEY4nZ4PrDuV+pyZoNwoPz08WhnP6WiFLNehEuknMnqvvl3pANLzO67k
	 /KQBtv/Q7z1Of+i30DSEUgyRdaT9mybZz8QUuZWtrSlK/wNob+gevwij/06hOeueOn
	 lsJ2IlnRIgsxk111caCUnm/UFvvupS15XTwtZebecLtiQDyRiqzjN6CSDY16/sTtzz
	 SnfC/egyneb6P83Dtm3PMTGy1lwGFdEUUAAgvj6CAZW54BB44Z7vMnFyz7Kq7KBaP3
	 HKq2nptBvLD1c7Iw09MkFlcwfqD6gwq+lDVBRF8Nb66dr7cKqurjKxYw62reqy15n+
	 KbachTLGfl8UA==
From: SeongJae Park <sj@kernel.org>
To: Deepak R Varma <drv@mailo.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: eliminate potential uninitialized variable warning
Date: Mon,  6 Nov 2023 20:49:37 +0000
Message-Id: <20231106204937.48488-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZUk5E7WSgHCpSteb@runicha.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Deepak,

On Tue, 7 Nov 2023 00:35:55 +0530 Deepak R Varma <drv@mailo.com> wrote:

> On Mon, Nov 06, 2023 at 05:07:40PM +0300, Dan Carpenter wrote:
> > The "err" variable is not initialized if damon_target_has_pid(ctx) is
> > false and sys_target->regions->nr is zero.
> >
> > Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Should this be a void function instead as the caller is not checking the return
> value.

As I mentioned on a previous reply[1], I think the caller should check the
return value.  I will send the fix for that soon.

[1] https://lore.kernel.org/damon/20231106165205.48264-1-sj@kernel.org/


Thanks,
SJ

> 
> regards,
> deepak.
> 
> >
> >
> 
