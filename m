Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFE35E1C0;
	Wed,  3 Jun 2026 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463077; cv=none; b=op6o/PdpwJC0wHYwsD7G7qmw1cA8nIbVAmeyCPu04/zp5R45NtQLMQJiYNhS1fTwVmhNDo46ejCbT617So5RK6BDdM+YeT6QC0QyWWIuDLAUjsoRQF0O/ArqJipdxjPRNlAMKvwEXHXiHfQgFQ7A+dEC/WZWaIoKTxA5TIM6OMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463077; c=relaxed/simple;
	bh=6mserEIyITYcFDXitVwYiWvYED02QbaWKmDXqXaHUNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZOamkw7dnmOgqrzePzb04VpTeDD8YOx5YBujLFQwiJuIrgwQ7gQ9EMMM62wqizpSxJEWKGca2HWioLxKkPZT+8zw++/9fj2X0dVP0OAG+MVrDkChkASdPuZdFBeQTvvigrXx84ysSUU3PhWFzCYEsLoyr4YQ6kga88zhroH0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daeM3HzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daeM3HzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756B41F00893;
	Wed,  3 Jun 2026 05:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780463076;
	bh=+xQ2puumFJ/2qiURGzPXh82LgAz5H1aStJvJVqAWBJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daeM3HzHogcgvKfFDLjYf3G1ILtAH98A4F7+Inlhar4Wicp1Pbpy4AfFwVCHwFkPj
	 +qcf/Gbr3N4gbgDDIEpBEdkOXUwYR0sqhBicrHA252SfGIt2KGS5ypdhFz7JJTVQRg
	 cv3AFOvaNK6vv4iJcj4GfKC3aDERXjNDDSgMUkwRosfXrO3Vy2VZEuoWaLcEEwcBvI
	 EJ4JKmCEAzNIol3zyVHGMDiC2zNbx4henShoYE+xnDJ2g43yJRXULLeG+P74/WZIOM
	 JU60UQBgEn8pO9ndZX3zCB7dbq91swWI6vG0b7tIBV2LbnCQcJZ3Zzkvro9row33e5
	 N+IXQrJzXfmDg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Cheng Nie <niecheng1@uniontech.com>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/2] selftests/damon: fix memcg_path staging handling
Date: Tue,  2 Jun 2026 22:04:26 -0700
Message-ID: <20260603050427.91866-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601145501.116884-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  1 Jun 2026 07:55:00 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon,  1 Jun 2026 17:01:19 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:
> 
> Having a sentence for the cover letter would be nice.  E.g.,
> 
> '''
> Fix a bug in _damon_sysfs.py for damos_filter memcg_path setup, and add a test
> case of it in sysfs.py.
> '''
> 
> > Changes from v3:
> > - call stop() for cleanup without checking its return value
> > 
> > Changes from v2:
> > - configure memcg filter before start(), remove commit(), ignore
> >   start() failure, verify memcg_path staging readback only
> > - use print-style error messages as suggested
> > 
> > Cheng Nie (2):
> >   selftests/damon/_damon_sysfs.py: fix memcg_path assignment
> >   selftests/damon/sysfs.py: validate memcg_path staging readback
> 
> From the next time, please add links to the previous revisions [1].
> 
> For other readers,
> v3: https://lore.kernel.org/E4B88E7D4879D1B1+20260601074250.203583-1-niecheng1@uniontech.com
> v2: https://lore.kernel.org/4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com
> v1: https://lore.kernel.org/406BD1BA0F6AE326+20260528081039.1192194-3-niecheng1@uniontech.com
> 
> I applied this series with the cover letter sentence change to damon/next [2]
> tree.  If this patch is not added to mm.git in short term (~1 week?), I will
> ask mm.git maintainer (Andrew Morton) to pick this.
> 
> Andrew might want us to repost this series after next rc1, though, as we are
> apparently wanting to make mm.git more stabilized at this point.  Andrew, pleae
> let me know if so.

Apparently that's the case.  That is, we are now quite close to next merge
window.  We want to focus on making mm.git more stabilized and therefore ready
for the next merge window, rather than adding more changes that no really
urgent.  I understand this series is not really urgent.  Hence, I will request
adding this to mm.git after next -rc1 release.  Let me know if you think this
is really  urgent.


Thanks,
SJ

[...]
