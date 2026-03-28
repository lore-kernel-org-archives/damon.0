Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4040DFA4
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656846; cv=none; b=Ao7+BTbvmBSjrgEH/OcVxf7sBNbjJ2q3uLnfbIsGjI9EePpqt3FWrL4kTux+X0W3Hsy7Cg2U5QRlDAWOGsxYhOCQbVbaC3rwz3Xuo2fnhJggDNhZIWfR2iMzsOV0xx25gPfY/YVYIPbD0N3+Gh96dd/rhLM6LqzdVYyKfN+ZAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656846; c=relaxed/simple;
	bh=6UHJ3gswMuWjAmgkFB4STXl2KbWhwJpWgDAWBYzUqpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4v79OCUnQUBlWMtXm8x1/K4HU6F732gCa8DlGx163kAogKU2UPBjcSHPzS9M0CYKFmxQoR9s3WYFpipJucZZpXvVxEaXdrtSO1nMKbvjUdh9F83AfLRgDsqXiOVEpLaSMdI/lVmyCy+Nu+3zQDpdprEFFlRT0rbi34XiObSuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPEMvVsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPEMvVsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09412C19423;
	Sat, 28 Mar 2026 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774656846;
	bh=6UHJ3gswMuWjAmgkFB4STXl2KbWhwJpWgDAWBYzUqpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPEMvVsUUP8GraCvy2ryJBS5ylEbMH/M7XaVX8UGrIaKl2HeAGB/MWdMhtgAz8uDW
	 hyWFw7JkBkZWNRMR2QhKIBt8bDe4pMDqhrl6Yt+Rin2/P2YnXNVoUkP2s0tNkG7eg4
	 HktkDZoko/ckd1GZswdk5voPkaxz7Ttc6qMcwEmpYsmjeu3O+G3AInHVoaAJZ0JWAg
	 g64NKzGQHL0RjVSsbg7zUUqPYzzWQrxxY13xfgtu8WfRXJ3AiNEJ0l2YUOlfoKLPha
	 HFb1UhTQe5cuA8qRnud7AAHPkn+VLfZa2CWbSFDz/wKGSgR4jZhrvGDM3F79Vc+HAN
	 EK1RUo0c1i3dw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 17:14:04 -0700
Message-ID: <20260328001405.4253-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327145627.10419-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 22:56:27 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> Thank you for the detailed explaination and for pointing out the
> 'PAGE_SIZE' limitation. You are right; and I should have accounted for
> that.
> 
> However, I performend further testing to address your confusion
> regarding kdamond's termination. My patch didn't fix anything.
> 
> Here is my reproduction:
> 
> # Log (Both with and without this patch):
> 
> 	# cd /sys/module/damon_lru_sort/parameters/
> 	# echo Y > enabled 
> 	# echo 3 > addr_unit 
> 	# ps aux | rg "[k]damond"
> 	root    71  0.0 0.0 0   0   ?   I   22:26   0:00 [kdamond.0]
> 	# echo Y > commit_inputs 
> 	bash: echo: write error: Invalid argument
> 	# cat kdamond_pid 
> 	71
> 	# ps aux | rg "[k]damond"
> 	# ... kdamond terminated
> 
> I am very sorry for the noise caused by my misunderstanding of the
> sashiko review.
> 
> The real question I am facing now is:
> Should kdamond terminate itself when damon_commit_ctx() fails due to
> invalid user inputs?

It would be better to not terminate.  But not a big deal.  Users could be wary
of the consequence, as long as it is well documented.

From my perspective, therefore, code maintenance is more important.  If we can
make DAMON not terminated by invalid user inputs caused damon_commit_ctx() but
it introduces a significant amount of code complexity, I don't think that's a
good deal.


Thanks,
SJ

[...]
