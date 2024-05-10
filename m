Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30313B789;
	Fri, 10 May 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376761; cv=none; b=PyfZ06Pw7C0NGZI/03v2BmG0nWdPhTlapp3angw5LCrabm4B9BhBRm5q/HS7PGmvEQ+VaqU97X6GaOXI4MLE7fTlCYouvLVzcu8BiF9HZdO+lRyT0pY8brqAb5F0tFaihUM0FySf67pVXlH9eazCj5/UVjaEwJ51eVGL4MbMlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376761; c=relaxed/simple;
	bh=YHUkn0DBgRxNFkE5O93KhO8NvrS0xHwlSDnVGFKOBN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdArvvpAb+GRUPAV6QapH4zwCLxOr3AS2yGpsvkTHAbTbc1eWglqdd5ArUpVZmNqzSSqRE7JyclMpKdYZJCZlgFDTBU9pD0Anmkp8p19OZdvkR/uJUYZGyQm3Dg25y5lXnuORIK1bI8XdkfEmGy46inBj/FDPoJrqltlTzMJkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fppYAeQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fppYAeQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8CBC113CC;
	Fri, 10 May 2024 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715376761;
	bh=YHUkn0DBgRxNFkE5O93KhO8NvrS0xHwlSDnVGFKOBN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fppYAeQbXB2EgJQKx9pxYFna2I03KFz39P7YCUvkBadoTP1+qt6vXnznE3DAj9mYK
	 SQ+XaYqOteb3jqtYsuGc8No1ty8swNYYP6YsOfU26/HY66vaycABJvOyl/Cbp/mK4J
	 FnzCjxiS3Z63Wf+6VFMGAFJFPVx7JIrwgsL40T7ykscfYjd61eG9koTnu5o+gFW5/O
	 OqU8a9ha8IR3jW302KCktxOtekhSqip7pj/gFSUf8GotvSVeSCl4bJ9tq6DXGAu5Wp
	 La7jjhkr5XS4Ubsn4dqQsw3EP2fhjHpuhc5MbpwLghIGU1BGR1wJQDWL2APvhbxqB1
	 bjsZSKbnWsQug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates and Plans: Automation of DAMON tuning, tiering, and VM guest scaling
Date: Fri, 10 May 2024 14:32:37 -0700
Message-Id: <20240510213237.83479-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510212132.83346-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 May 2024 14:21:32 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> On Mon, 29 Jan 2024 12:47:49 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hi all,
> > 
> > 
> > Thanks to the discussions and feedback that we received last year from the
> > LSF/MM/BPF 2023's DAMON updates and future plans session[1], DAMON made many
> > advances and yet more future plans.  I'd like to again share/discuss the
> > followup changes and status we made so far after the last year's session, and
> > the future development plans on LSF/MM/BPF 2024.
> 
> The session is now scheduled for 2024-01-13 10:30[1].  A draft of the slides is

Urgh, sorry for the typo.  s/01/05/ please.

That is, it is scheduled for 2024-05-13 (Mon) 10:30 AM Mountain time (UTC-6).


Thanks,
SJ

> also now available at DAMON slides repository[2].  Please note that the slides
> are only a draft.  Those may be (significantly) updated until the beginning of
> the session.
> 
> Looking forward to see you all at Salt Lake City!
> 
> [1] https://docs.google.com/spreadsheets/d/176LXLys9Uh6A-Eal2flrzcbUSJMUXGkGwyihr9jAAaQ/edit?usp=sharing
> [2] https://github.com/damonitor/talks/blob/master/2024/lsfmmbpf/damon_lsfmmbpf_2024.pdf
> 
> 
> Thanks,
> SJ
> 
> [...]
