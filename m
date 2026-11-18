Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967636;
	b=XtnhXkDHNLGPxdg7UJo4j/2H4XJtmJKZbSIQCDm094fa5zEeWdG14imAusrd0WJLw+/1
	 W6l8/rK/0FDJr2WgijOWME36XSN3vVTHKc+ARwW9+VzCKnNo5RZF9RFZ1yP54S5Ph+9S7
	 sBg/HcTz/V9qjAQqKgpeFOjbnNpVjgkyCwgO70EqhZK08bsPwoKciTxBgIvrXSCpXAmJz
	 D9aVjxly70JjrnL49Cy9MGtZzfxNna//6/Hbt/UmNvhe6wcghnzLqilOxBTQY8mzPWXVO
	 JZcYaUwEE5379qqZk+4Z/xfLhm/9rjsxtPlTEpT+v2KA8opF5Yt0LfeWMZy5cY974hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SfJwYwm5e4vsMzXCNz9yx/bfvNCh4e6ZadaT7dtFFCc=;
	b=jfjA1dt8/EZY2SxNwVw3bH8E+zCmRq4WqyInQYt1cc0RhNRfdiIpfuR7jOxCz7Z21FQ0
	 Fk7zxRN6eZxfck0HBSA46kbqFn/jypn/0DNrO8pruB9FVaZypMe1zkty6UMeREw/uCky9
	 jY+LOn62vpvpCz6168TbdenNzWlaJRdg1/yv83om7wH1GqH/sxRLLSySsYs1B1QJ8tZUE
	 Y6x9KuZq1krCovRfTkOJSN2WYUudGAIrXnk+pw73G+73qtsfwJCDMbGXlBbLra1n1q/zY
	 g/DFmJ8ZUb7HV9el9sKvdtrL57Hj/xYA9AZnVPV2rpTZjld9sj/di1PMp//slUA4mRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxS0Otyy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B03606A31C;
	Wed, 18 Nov 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxS0Otyy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9151F000C4;
	Wed, 18 Nov 2026 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967636;
	bh=SfJwYwm5e4vsMzXCNz9yx/bfvNCh4e6ZadaT7dtFFCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxS0OtyyAIerLsAhqGBRZ+KTdGsIkmq3EWg7V/diqU8vep8orjnhHHMpfi8HdS/e8
	 5CmV4owJrPu9fVMDWqrP3PXnFDuGAFxOaWbl9nbawe5aBx8OmbUcTRdGCuN+8szwLm
	 DzEqrqHJvaQSXYaDpZsKoIjy+ePZyuap0aQ1vEfQgM6F47xKF/ewaUbsZyqE56eT1o
	 sSZIdd8GUjB2BZqHlC4ABa4Wpfnx49lcjt5R3KAAiANpXhY/jtbLp+zRzJYnEaoAau
	 PpPfsxAlxmuqUWpmLp45IjLc1wrfkR2ugyBHxexfl7s/cEMqNpWaGj2HapQa9pzGe3
	 ou5Yf9OOHZUkA==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH v2 0/6] mm/damon: add sz_ops_filter_passed_last DAMOS stat
Date: Tue, 17 Nov 2026 18:07:08 -0800
Message-ID: <20261118020709.97589-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 23:22:14 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> DAMOS stat sz_ops_filter_passed shows the total bytes that passed
> operations layer-handled DAMOS filters, accumulated from the beginning
> of the scheme's execution.  Users who want the amount for only the
> latest apply interval, e.g., the size of a workload's anonymous memory
> that is cold as of now, have to keep the previous value in user space
> and compute the difference.  To know how many apply intervals a
> difference covers, they have to rely on nr_snapshots.  But nr_snapshots
> is increased once per target per apply interval, so the computation is
> complicated for contexts having multiple targets.
> 
> This series introduces a new DAMOS stat, sz_ops_filter_passed_last.  It
> shows the amount of sz_ops_filter_passed increase in the last apply
> interval of the scheme.  It is updated at the end of each apply
> interval, and kept unchanged until the next apply interval is
> completed.  Like the other DAMOS stats, it is exposed under the stats/
> directory of the scheme in the DAMON sysfs interface, and refreshed
> together with the other stats when refresh_ms expires or
> update_schemes_stats is written.
[...]
> Changes in v2:
> - Patch 2: join the attribute declaration onto one line 
> - Patch 3: call damos_set_filters_default_reject() before adding the
>   scheme 
> - Patch 4: keep only the stats list bullet, dropping the explanation
>   that the stat is not accumulated 
> - Patch 5: wrap the stats line in the usage document
> - Link to v1: https://patch.msgid.link/20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com

Thank you for addressing all comments I added to v1.  However, you didn't
directly reply to the comments on the v1 thread.  That might confuse some
future readers.  From the next time, please make sure the previous version
thread is complete by replying to all comments and waiting sufficient time to
let any other chime in if they have opinions.

All patches in this version look good to me.

This series is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
