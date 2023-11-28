Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBC41C6A
	for <damon@lists.linux.dev>; Tue, 28 Nov 2023 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8HREUCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E4C433C7;
	Tue, 28 Nov 2023 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701197862;
	bh=KIRVGvgTEo6MU+1ULyVc42k3ON+LvmquMKcr6ZnGB3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8HREUCGIlGLBK181OWcIiiwNM7az5F2/keOGgEmCp1N5CBiZzZbIyXGkTl6cDRpZ
	 h8Mi1fpXus+5yAlhYTVVXAYfH7HJLlst3bzpeA3U7tcnwQIWVrBMSr/Usib3aA94xe
	 43YUMNYUrAwk4y4uxr79scpnrC7f104NNqHAMUDt/XVR2L/xJtvhva7P0D98UW/nDH
	 XT4K889yFY1VzQ73VM0o4ScUzCecJhELMaZk/1t/YMFcn+jE+hNAbqtpGWR00D9pxS
	 iRXFetT1MZuufpT4Lb20BBecXM40n0krFVJFr/EoSATB0SBnyhdV7Qg8SY/BcvhZIn
	 D93uAYnLbXatQ==
From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cuiyangpei <cuiyangpei@xiaomi.com>
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Tue, 28 Nov 2023 18:57:39 +0000
Message-Id: <20231128185739.47916-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cuiyanpei,


Thank you for this nice patchset.

On Tue, 28 Nov 2023 15:34:39 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> The user space users can control DAMON and get the monitoring results
> via implements 'recording' feature in 'damon-sysfs'.  The feature
> can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
> damon/admin/kdamonds/N/' directory.
> 
> The file allows users to record monitored access patterns in a text
> file. Firstly, users set the size of the buffer and the path of the
> result file by writing to the ``record`` file. Then the recorded
> results are first written in an in-memory buffer and flushed the
> recorded results to a file in batch by writing 'record' to the
> ``state`` file.
> 
> For example, below commands set the buffer to be 4 KiB and the result
> to be saved in ``/damon.txt``. ::
> 
>     # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
>     # echo "4096 /damon.txt" > record
>     # echo "record" > state

This reminds me the record feature of DAMON debugfs interface[1], which still
not merged in the mainline.  I deprioritized the patchset to have a better
answer to Andrew's questions on the discussion (nice definition of the binary
format and quatization of the benefit), and later I realized I don't have real
use case that this makes real benefit, so I'm no more aiming to make this
merged into the mainline.

More specifically, I'm now thinking the feature is not really needed since
trace event based recording works, and we found no problem so far.  The DAMON
user-space tool (damo)[2] also dropped support of the in-kernel record feature,
but we received no problem report.

Also, I believe DAMOS tried regions like feature could provide some level of
information, since it provides snapshot of the monitoring result, which
contains a time data, namely 'age'.

Could you please further elaborate your aimed use case of this feature and the
advantage compared to other alternatives (tracepoint-based recording or DAMOS
tried regions based snapshot collecting) I mentioned above?

[1] https://lore.kernel.org/linux-mm/20211011093057.30790-1-sj@kernel.org/
[2] https://github.com/awslabs/damo


Thanks,
SJ

> 
> Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
