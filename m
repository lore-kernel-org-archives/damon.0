Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015A3D5C2A;
	Fri, 18 Sep 2026 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699150; cv=none; b=nfGEtwO2GLOGhoFSZhMMk5Vf6TRdLFfiEOAHiG3VbS4v6ff170fwg4IhF+IK5YZ25+pa/ck7qCu2E4PdC88rVG1nsMuM3YqWSNh+qgp9bdpK8e8CYyO1Z+leP+CWfjRN5URhIKu+rqUG4uyCaNO4HMhISETxRfKwCYgRZfVMfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699150; c=relaxed/simple;
	bh=lVcb7JMl9+mQgNhF1+gbNYM+yWP9vUq59rxw4DlhIZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBWXfh5Hi1laNHupp2g4CBFbddsFRJcPpojue/JabUcAYM0K8kiVHw8kSraEzOvR44wDaBuM/5VsSJicPlFMX8pe40lE0QY9vpK73uWlNymFOzB89DwE9a/7Dv+zE/CmNEbiWS59qMgKbc0oZDDMOS2T9Ek2IPJgOlAgMqoKFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiP7VDcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiP7VDcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE8D1F000FF;
	Fri, 18 Sep 2026 02:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699141;
	bh=XFn+Q7rC2VQ5SocqsOrcZJwTW1fdmqaD8YlZTdVp2Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MiP7VDcRQNxMZAViYh9ABN4d1iXEi+V+WYJvnsLJAWfhT+7QAEotrRl6/3uITknyl
	 6ttkv7XDTs0ivbLlBK3OAqzmDL9aj7TLgOpOkmxJYOqmcfG6CiWZX0VRwITgxVfG9O
	 Ai0TSUZsRilaiaPW83IHQgYwu6lIZpA/s5BpV38Q8m2y40zOoOBC0Qu9oVv4AN72TB
	 S46vabyDMQ5O725glZrJD9WbtjIOYpUauf3tuqnzBHLQN4aGPyd5VYRN1+7p4+kE4p
	 uW4LOKg+ciwSt4XlhEXu+ClA50kwYL0IpZxAPoQnsuUsDECimD0zW5p1MueQwKA+HO
	 qD+IjFaOgQtqw==
From: SeongJae Park <sj@kernel.org>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: reject zero sampling interval
Date: Thu, 17 Sep 2026 19:38:58 -0700
Message-ID: <20260918023859.13556-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917180013.1279018-1-karthiproffesional@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Karthikeyan and Sang-Heon,

On Thu, 17 Sep 2026 18:00:13 +0000 Karthikeyan KS <karthiproffesional@gmail.com> wrote:

> Hi Sang-Heon, Hi SJ,
> 
> > I think SJ already commented on a similar patch. please refer to [1]
> >
> > [1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

Thank you for pointing this out, Sang-Heon!

> 
> Thanks, missed that thread. Same objection applies to mine.
> 
> > Can't we keep supporting zero sample interval and fix the warning
> > or the real bug instead?
> 
> I measured a few floors for kdamond_usleep():
> 
>   floor    kdamond CPU (3s)   vs sample_us=5000
>   1us      84%                28x
>   100us    42%                14x
>   1000us   12%                ~3x
>   5000us   ~2%                1x (matches control)
> 
> 5000us is damon_new_ctx()'s own default, and at that floor the spin
> is just gone.
> 
> Would you rather we just document sample_us=0 as accepted/expected
> behavior, or clamp it to that default inside damon_set_attrs()?

I'd prefer adding a comment saying zero sampling interval is accepted.  I think
damon_attr kernel-doc comment is a good place for adding that.


Thanks,
SJ

[...]
