Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FB7B
	for <damon@lists.linux.dev>; Wed, 26 Oct 2022 23:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE3DC433D6;
	Wed, 26 Oct 2022 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666825686;
	bh=H8xP8TrdD17wMSkTUDDHrIYwVh+7IjJyewOgaLdaUAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCEtxMWdBOZqbJlwTDSgk8aKBaoXJpSdiUZqOV0w10b3UldrQekZXZH5mi6jC4JcU
	 4d8TRGuHbcbEZBojBoioyUZYtqWs5I4h9DexIGUOVeFbn3AvXXMe84CELdYth4oAO6
	 CgGoQwq/nFsGK0sFT8KGUSEFdGrN4EWOBinPfPnfooM30LK+HWtCttZSU+iaHOGcux
	 f+eH8HGAOzSD3OocjZ02hOUFH4CghbLgHndg+d1/nDG5gqbZDBrhmnORT6Z/8BcxBq
	 NzcCY33BcucgXGm3gb5Ior13hc1Bd1PrlrHhz0mCLE6yi2toIfoIvcYmn1YGTwpvf+
	 TRZkookGfRX5Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 00/12] mm/damon: cleanup and refactoring code
Date: Wed, 26 Oct 2022 23:08:03 +0000
Message-Id: <20221026230803.100491-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Wed, 26 Oct 2022 22:59:31 +0000 SeongJae Park <sj@kernel.org> wrote:

> Changes from v1
> (https://lore.kernel.org/damon/20221024204919.18524-1-sj@kernel.org/):
> - Add 10th patch, which splits schemes sysfs directory implementation

As mentioned above, I mistakenly forgot adding the tenth patch of this series
in the previous version.  Could you please replace the series with this
version?

Please note that the 'synchronous damon_{reclaim,lru_sort} enable/disable'
patchset[1] relies on this patchset, so this patchset should be applied before
that.

Sorry for your inconvenience.

Also, please note that there are two minor DAMON documentation fixes[2] that
not yet picked in mm-unstable.

[1] https://lore.kernel.org/damon/20221025173650.90624-1-sj@kernel.org/
[2] https://lore.kernel.org/damon/20221024174619.15600-1-sj@kernel.org/


Thanks,
SJ

[...]
