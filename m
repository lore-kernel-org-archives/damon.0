Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B36110
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 22:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E9C433C1;
	Fri, 19 Aug 2022 22:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1660949092;
	bh=s8PKxoj54nX65XSLJWvwOlsXTFX9oxeU7c5M0X//TrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JHseprvTKx73mTepc3ANX5VSFgNTx8dSF5hSyR7qMWkHxt3k3vypwaBGHlaF4Ch0n
	 fq1HKIH4bvo2I6lHUYEXuLDORyil74A4LhL/rQbxtrRUxOX9kZSJwiShKVrdH6YBY8
	 IiK/D3zRr+Yqts1mWu+fPpcStMeL8msluSQwfzAg=
Date: Fri, 19 Aug 2022 15:44:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: gregkh@linuxfoundation.org, badari.pulavarty@intel.com,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/dbgfs: avoid duplicate context directory
 creation
Message-Id: <20220819154451.9f424d9d563969d9cc6437f7@linux-foundation.org>
In-Reply-To: <20220819211631.16658-1-sj@kernel.org>
References: <20220819140809.1e3929fd8f50bfc32cae31d3@linux-foundation.org>
	<20220819211631.16658-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Aug 2022 21:16:31 +0000 SeongJae Park <sj@kernel.org> wrote:

> > It would be simpler (and less racy) to check the debugfs_create_dir()
> > return value for IS_ERR()?
> 
> I was merely following Greg's previous advice for ignoring the return value[1]
> of the function, but I might misunderstanding his intention, so CC-ing Greg.
> Greg, may I ask your opinion?
> 
> [1] https://lore.kernel.org/linux-mm/YB1kZaD%2F7omxXztF@kroah.com/

Thing is, the correct functioning of the debugfs interfaces is utterly
critical to damon.  And that's apart from these memory leak and
oops-we-killed-damon issues.

So damon simply cannot ignore the state of its debugfs interfaces and
keep going along - because if something goes wrong at the debugfs
layer, damon is dead and useless and the machine needs a reboot.

Perhaps this means that damon should not be using debugfs for its
interfaces at all.  Or it means that the debugfs interfaces are
misdesigned.  I go with the latter, which, alas, also affirms the
former.

From a quick scan it appears that a significant minority (20%?) of
drivers are checking the debugfs_create_dir() return value.
