Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A62429034
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298232; cv=none; b=oC2zW4RwLcLuu59nP8cW8QN2LIqR43Go+C0I8IKXc3swxguVRlGPKIub7yaFDjn7GtIixWsGOyE+m3xEbF6kK82DFu/zQLZE58IwYNbU1+I9eM/BO9M8/PSmZXw97jqzxYQEJVkw/93vor2G4M4ZeAMT+8OH6b2NZqo4l+ARUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298232; c=relaxed/simple;
	bh=bya4GkcNusUpu1+WeBTQK++Un50HiB16dkNNDxcg1rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ouknr5NP+Q0Dt7KUCSfwoih5cTJBAgvVWVaX22uhU58YGOnt0v9pZW3fYw/XPVBTze/XDEIq+KG3na104Z8oG76zlIJBdo8/q6m43Z8XGAY2dDDZzdz7aZv1cDCL50MwhMhoLZz/V5mXz55Vgz+YitaCIDMhyADVpmYGmEF3b34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMS4b0B6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMS4b0B6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1011F000E9;
	Fri, 17 Jul 2026 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298231;
	bh=xcdtPjM1bbPwPM506mATotSv4YstCKTDfUkEdecfsbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gMS4b0B6qIQdlCdkrH81R10Sr9oN6Zo/1NYWWGrB75fggNBQRGXQnu08IWmsYgJOW
	 JcjMRJMfmbS902Jysdfd/4QbY4Zbfp9Bvk4lwMgXODxokJwPjdHFIMqOZhwTbD0QAd
	 PHVj9Vba+dzTHV4jWEVFpOK/ULCrKmpre7tK+oN3n96fdSnonv+Yyqqq8a0CCyb4G7
	 3tGY0ezK1fMb2Cb0XUrZXio5F0KLuDokd0qAideQhEqgVlhc26WPncLqqo3ZrQK7s6
	 e9LDBBufypTdKj71hUxYqOViK2XQriR0zD7pKELMujHgehhjXwRMVvh45N42DX0c6R
	 fpUTmqsqaW1QA==
From: SJ Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] samples/damon/prcl: add module parameter description for target_pid
Date: Fri, 17 Jul 2026 07:23:47 -0700
Message-ID: <20260717142348.27427-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <875x2ej95p.fsf@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 16:46:26 +0800 Enze Li <lienze@kylinos.cn> wrote:

> 
> Hi SJ,
> 
> Thank you for your review.
> 
> On Thu, Jul 16 2026 at 06:54:37 AM -0700, SJ Park wrote:
> > Hello Enze,
> >
> >
> > Thank you for this patch!
> >
> > On Thu, 16 Jul 2026 17:14:44 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> Document 'target_pid' via MODULE_PARM_DESC so its meaning is visible
> >> through kernel command line usage and sysfs interface.
> >
> > But...  It is a static module.  Is there a way to read this documentation from
> > the user space?  If there is no such a way, I don't really think this change is
> > needed.  If we want to document this, we could use comments.
> 
> AFAIK, MODULE_PARM_DESC() is for loadable modules.  For builtins, it’s
> effectively just a comment.

Thank you for clarifying, Enze.

> That said, if DAMON gains loadable module
> support later, having these descriptors in place means we won’t need to
> touch the code. WDYT？

I think it is not too late to add MODULE_PARM_DESC() when we add loadable
modules support.  As of now, no clear needs for loadable module support have
reported, though.


Thank,
SJ

[...]
