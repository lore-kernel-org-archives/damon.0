Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685E37BE7D;
	Mon, 27 Jul 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162878; cv=none; b=MLeMBFph9aTbveywjj6/IkoKQxK5nfkYwLnr5lE5PGfLU1eOZxjHMpVbpjxu+zzDrXtE4g5mSMmSJFLeaGm5eSYMmYauT5+RlMF74rpXooZQpySRGzj6Fo8uxJEMgRN9drvXZaTeFhRXYzXjNwKgIItYr0VtpaQM1NYQG6dgh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162878; c=relaxed/simple;
	bh=CxjvYJpzS+Roexhx7brzIhzirGEzQxoqzcfeHsbzb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx9mzn6GWMygfHzKSVhl/MMert2sdoisHPpuRAt1WdolLxpYk7EYTKNhSnB3NPKUbnA4ugxRtO8JCZqMg+8mlvMeYJopW7vtHHMX8jHrXM9Lu2FCTCVbemcvibu6t6NixxjNEBAHAiEyCQ+V8WfngmamB8l+jgEtxS4Pu3kTjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g35nxHXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g35nxHXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D71F000E9;
	Mon, 27 Jul 2026 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162877;
	bh=P4JHLF6Mi/GxghJ2fQ1a+xylYvWRq6tTrCeZSqHjYps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g35nxHXIiFLFQgEgbWd4pLcZOp4ymxKryP53wty2vXI874BrAsD8HlPn0xA5bYRKp
	 gTWhh9b0MK/Jwk/9RJhcgLuVhvfZM6MdcNiat7ejv8F3Zx0iDOvmQFwDVm+vUu83vz
	 g13dzTIaKm4MxrXVehBPvPONqDq1gndNg9t541sthDeKoMF9t5BQ/tM6LaL+k/3D5T
	 vurPNtrjzmUDgADKZr3j0vqLiQ+q1RF+6Kbh0/YFHWVqISde4TJ3Jia4LcfC14K0bZ
	 w5oDTGoxnGZ/bKDaNY53/5dJXxh807K8xIlyXIV+15XNF2xD8f1bu6nWso4n73FiSq
	 6SWzILuaBG9uQ==
From: SJ Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: report the number of tried regions
Date: Mon, 27 Jul 2026 07:34:33 -0700
Message-ID: <20260727143433.85732-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727095429.143527-2-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jiayuan,

On Mon, 27 Jul 2026 17:54:23 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> The 'tried_regions' directory of each DAMON sysfs scheme exposes the memory
> regions that the scheme's action has been tried to be applied to, as
> per-region subdirectories.  It also has a 'total_bytes' file that reports
> the total size of those regions without materializing the per-region
> subdirectories, so that users can cheaply retrieve the aggregated result.
> 
> The number of the tried regions is another useful aggregated metric.  When
> the scheme's access pattern is not restrictive, it approximates the number
> of the adaptive monitoring regions of the context, which users may want to
> watch, e.g., to see how well the monitoring is refined under a given
> max_nr_regions, or to feed fleet wide access pattern dashboards.
> Retrieving it currently requires materializing all the per-region
> subdirectories (via writing 'update_schemes_tried_regions') and counting
> them, which is unnecessarily expensive for users that only need the count.

I agree the number can be useful.

> 
> Add a 'nr_regions' file to the 'tried_regions' directory.  Like
> 'total_bytes', it is updated by both 'update_schemes_tried_bytes' and
> 'update_schemes_tried_regions', so it can be read as a lightweight counter
> without materializing the per-region subdirectories.

You could also get a similar information from DAMOS stat, specifically via
nr_tried stat.  Have you considered using that?

I'm holding reviewing detail before this high level discussion is done.


Thanks,
SJ

[...]
