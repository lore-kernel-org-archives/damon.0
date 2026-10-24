Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875962;
	b=vtMyGCpJcclxlZpcP64KZoyWwF3cCARL0Dus6ng7gs0QEhFt44/qdMbQGJS3OP9ufIWL
	 mKfpO5MpFgnRYfW2VcbEBBbn0gfC2MjXCFcVuQXOXzaSNcimfenwiSgM1FauBO06D+YPm
	 5oTI+OMnBIc3zDYcasf3oxycbQwV6Q8rwNoJ2M5fHF0lbh8Y+d+v3jvpoXPPkSEFY68TY
	 lReIW9EMCgdzBXIt1Vy864GVx1e1RGjlXbsCUuGPxcwqOYq25nQ6AX+b7kkC2+aazygCx
	 EPgrs7TT1U6pV/tEtRZJD+GGCq4rx+d8xzl0cDKKvc12CSMh8BLyOw14YW8XwT0uMew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DEsKqDozT8n8jNTNyGDSZhCKcPX9RBFL/scJ3pbGQhs=;
	b=FBlPE02PsvxguOP5Y9GfDbnEcjlvGFJxqqa+E1TAdz6fH5yQRTM3Vft+8HXjSK93bs3v
	 B9eKb7Yzv9nxRe29U+yaQTB158R2neyiy8BlRVvtYEIGoU2sq/K3+rbFPGRDhsTRaiVyb
	 WQBHVuXqcRgk0wf2WIFxnGXuWJD44jgbnnKiFJcPcYUX7R3F4B3hFwQnXOWR4cWYMtugl
	 yXNfI1epDzAVmW5twIIitL32IWmX4+cIKwn36a2ylvTosvxauCOaxY3Aemnmav5ejrFxE
	 B7nOF4D0F+vcE2ynZifVCI6ywaun79HgQBR6Y/q243FFkesG/ZIPpZB+oI65W/koonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezNgzsb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB7606A31A
	for <damon@lists.linux.dev>; Sat, 24 Oct 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezNgzsb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387621F01825;
	Sat, 24 Oct 2026 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792875961;
	bh=DEsKqDozT8n8jNTNyGDSZhCKcPX9RBFL/scJ3pbGQhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezNgzsb85kahEwcwhrlzwf36YMCMkDLQZRknAlrRVmPpefT08RBhYoq+eB7DeCkZw
	 V1wdd0+bOhX3JCa2Wt5676K40aDQ+Stkvx8K7oKHHh9GkNL6Kf9Z8tKhxeu4Z31o2c
	 Qz/WwwwHtpF8h7F4Iq+LxSzlGyl76BRFtaJZW+Kw7BU31QD2FQCD4XRGKsNX5DquUG
	 062Kud6LwX+ltIYp+H4IaWL4qmyHdmLiWySvk5JkI8LV2x8PK2YB/1ToQYe/kHU9GX
	 fr7pMCoH0kRc5FOT3oqelD/9Sd3E5jm2GLYqp2gPWqXY+PbQOFzsVmTL9PY3WwNfOw
	 Zm1+7ZMcmCpyQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Subject: Ways to handle Sashiko bug reports for DAMON (was "Re: [False Bug] mm/damon/core: uninitialized boolean fields in damon_new_scheme()")
Date: Sat, 24 Oct 2026 14:05:53 -0700
Message-ID: <20261024210554.88440-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024195239.87431-1-sj@kernel.org>
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

On Sat, 24 Oct 2026 12:52:39 -0700 SJ Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> Sashiko reported a bug that I believe a false positive.  Sharing the report and
> why I think it is false in usual mail format, to get help from more eyeballs.

I was about to keep doing this for all false positive reports.  I added a
comment on the Sashiko web ui for this report, closed it, and opened another
report that I think a false positive.  And I realized this is tedious and not
sustainable.

Actually nowadays I was taking time to think about more options.  Those include
but not limited to making more tooling and just sharing everything on the
mailing list and forget about the database.  I still find no best option.  And
I feel like I might spending too much time on this.

Maybe I'm thinking too much.  I will just do whatever I feel better to do at
the moment.  So I might share some Sashiko reports on mailing list or not.
Maybe I will start from just not sharing Sashiko reports on mailing list except
mentioning those on relevant patch descriptions including Closes: tag.  Please
don't expect any consistency in my way of Sashiko reports handling for now.


Thanks,
SJ
