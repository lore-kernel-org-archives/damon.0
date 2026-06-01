Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F23CBE96;
	Mon,  1 Jun 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325707; cv=none; b=oS5nCHKHBipmc7K1R6uenY2odU0NbICeOnf4r9NIbZZnuVDxq/GTlYn3Vt/qWnI2h/K7aekKYi6NbfVLp6UadfQ8VtBml3eqvzj0vtK0LureB2bkIRF4sWdw2Dzh4Lx9ftCwU5HUou4xZWKhtmBiez4HF/E1WaNvIprZZCh07Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325707; c=relaxed/simple;
	bh=g3L2vnZdWxQCOYAsUPfnT9syV+tmv3JLNZgI0eqgIoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzQB7KsWDhMz/pvhn/SEMF9xc6FjXteUsjBs2DC9LtSDYTAzU9a7ehiGl24jtAlKBwT2Cic9g9qii/5rakFGe7FLDHSldaAQhn6iEvRdTUu4VmMRcFifbdjDxNcQC84RGUiFE7BMJvPgoqJkMd0+KMTkklvd2UWBNAfF92KAQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWA01ekr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWA01ekr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB751F00893;
	Mon,  1 Jun 2026 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325705;
	bh=XG5RfpJwti7dylwLwxXSrJ1QM98QSD9PaVrRVudv0Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWA01ekriVpl9LuiMtnhLBxVRpoAQnrdChloT38CbGJDV3n46PNj9lXgod7r7P1TR
	 vQr2c7hP3Stey87+7vLgfxaJ/wkIuejsS8ukh+QSf9PPPc2fWoZ/5ruLFKkjHjomyG
	 7YvvnFHrNssF9j31/K3Pvfi97TIV+gUiIDHQFeprTz+DFnSDwRX06x+qPEPn1goxFW
	 7PwV4gJLoWq86CSywNOXMq2Tf9/vgQNtlwOgFPHxOEvdTqfkZb23MwWCrC0ScUl/uL
	 4KqIiRiTTV9t+z/dqXuehSsauPWhwHy4sLZTByGhnifdJvJ6QEsIm9FVf9zfp0LQpB
	 I26fQQqcCx6Eg==
From: SeongJae Park <sj@kernel.org>
To: Cheng Nie <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/2] selftests/damon: fix memcg_path staging handling
Date: Mon,  1 Jun 2026 07:55:00 -0700
Message-ID: <20260601145501.116884-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7E6EAB7C1BE04DEA+20260601090119.238457-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  1 Jun 2026 17:01:19 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:

Having a sentence for the cover letter would be nice.  E.g.,

'''
Fix a bug in _damon_sysfs.py for damos_filter memcg_path setup, and add a test
case of it in sysfs.py.
'''

> Changes from v3:
> - call stop() for cleanup without checking its return value
> 
> Changes from v2:
> - configure memcg filter before start(), remove commit(), ignore
>   start() failure, verify memcg_path staging readback only
> - use print-style error messages as suggested
> 
> Cheng Nie (2):
>   selftests/damon/_damon_sysfs.py: fix memcg_path assignment
>   selftests/damon/sysfs.py: validate memcg_path staging readback

From the next time, please add links to the previous revisions [1].

For other readers,
v3: https://lore.kernel.org/E4B88E7D4879D1B1+20260601074250.203583-1-niecheng1@uniontech.com
v2: https://lore.kernel.org/4CDA28DC581FDCF8+20260529090845.1696845-1-niecheng1@uniontech.com
v1: https://lore.kernel.org/406BD1BA0F6AE326+20260528081039.1192194-3-niecheng1@uniontech.com

I applied this series with the cover letter sentence change to damon/next [2]
tree.  If this patch is not added to mm.git in short term (~1 week?), I will
ask mm.git maintainer (Andrew Morton) to pick this.

Andrew might want us to repost this series after next rc1, though, as we are
apparently wanting to make mm.git more stabilized at this point.  Andrew, pleae
let me know if so.

So, no action from your side is needed for now.  If it seems I also forgot
doing that or you cannot wait for my action, please feel free to directly ask
that to Andrew.

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
