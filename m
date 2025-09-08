Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F12E0406
	for <damon@lists.linux.dev>; Mon,  8 Sep 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362740; cv=none; b=dek4BLhqresfdZ+pVHsMcflxC0X90kAH0ek9/xQ5q9gyszfJq4FKQ2okCjBV7jBtHWaZXBJl3Y+af336fQJdeUhxEjadPKlHVijezwkOJ3deMRC38rT9u1veWBziFrkXKQmHOW3OU5AFTXv02/1nxdm2PPM0mZHKjLOv5S1cyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362740; c=relaxed/simple;
	bh=0HK3LqtlvREIDafpZoY0WMwXjqbfCvvMiP0hjefrKR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qK7shNSkDml+ngZt5QOmf+COSKNYzfTQuAB+gGn+Q5IK0YYmx7ZcGWGMYStsspI7GXXhVIdOfrxoBmJXABsgcbSIkMVlcxQdefgQe5+lap2KxUUzCiqT6FpIHILf8zZ8rrZ6E+MYoun84Vauf8PiU6ASmcu+mn+sfrVtEPTZwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSI0nU35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSI0nU35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9430AC4CEF1;
	Mon,  8 Sep 2025 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362739;
	bh=0HK3LqtlvREIDafpZoY0WMwXjqbfCvvMiP0hjefrKR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSI0nU35vgdTbbai783EKqIVNR4PUj2ygXWr4bcTOewyDPjMaexzpDDAIxnjFpJY8
	 XLe2xZSF5+zUIOW5FJmSq7qu40aEcatR+i35Qzh5oe+ZCc+r9AbotWOWzaEB6EVwXy
	 PLq+jQEY5hbJCaKkpmcB1N8Qi7s4JK5TAcWOuLxPbET2Lqf1KsqWaYnMEN5MTOLBnt
	 GkhufZahTdhYsWpzPo5rKQZOkZP0xCTpbDebvxg10zVH+s1ef0/Yv22k3xkytyE8XE
	 mX/pvuTYyXzE9FboyylGklPUHSx9ap/bnn8DebPTybQI1g2+K9LRsWRBapn3R7YZ57
	 wC6FbdDA6YrjA==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Mon,  8 Sep 2025 13:18:57 -0700
Message-Id: <20250908201857.61253-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908043619.1085-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  8 Sep 2025 13:36:18 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi SeongJae,
> 
> On Fri,  5 Sep 2025 13:07:41 -0700 SeongJae Park <sj@kernel.org> wrote:
> > On Fri,  5 Sep 2025 18:08:26 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > On Thu,  4 Sep 2025 20:54:11 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > On Thu,  4 Sep 2025 17:29:45 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > > 
> > > > > On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > > > Hi Yunjeong,
> > > > > > 
> > > > > > On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > > > > 
> > > > > > > Hi!
> > > > > > > 
> > > > > > > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > > > > > > I tested and confirmed that this issue also occurs in v6.17-rc1.
> > [...]
> > > > Thank you for confirming.  I confirmed attaching patch fixes the problem with
> > > > your repro on my setup.  Could you please also test that on your machines and
> > > > confirm if it fixes the issues on your setups, too?  If you confirm, I will
> > > > post it soon.
[...]
> I've confirmed that this patch also fixes the issue on my physical machine. :)
> Thank you very much.

Thank you for confirming!  I just posted the fix:
https://lore.kernel.org/20250908201513.60802-1-sj@kernel.org


Thanks,
SJ

[...]
