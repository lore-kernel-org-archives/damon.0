Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF647F6A;
	Sun,  2 Jun 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343776; cv=none; b=mnrw8GhlxRUt7vzY6YDwtnbrsoy/JcUEnv1wGcEJSDb5PInaA61/rnVdqnD5HGTo8ILtcLSPy7awfmfDHCm7nEet2PDnbnNyvEkqQ15TRTlt+C6rkPkPr19pI430wFjBOZHIX2W7bg+V4yF1OqJ16BdvF0o7ghUmP2JVFFmcA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343776; c=relaxed/simple;
	bh=l8+GXFRaLRqbnJKvA06bKbF87+GahGFEyqWYIo+UKmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaKrPZWKsUa7r2ftipmjp6cly3DX6Z2is5qDsH0idEri1vsBi39AwLA1tnZeo+o7Uvl5Y1QBF5fefS6yG2nSjZZOKDKv3qRbqixpyNuZqbykKj7ieMpgO4RRyRBMAE1Dddc4u3GzNj5mA8yWpvIuS3GTMY7nDmnQ/7SdRaemC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHHH/F8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHHH/F8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F6C2BBFC;
	Sun,  2 Jun 2024 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717343775;
	bh=l8+GXFRaLRqbnJKvA06bKbF87+GahGFEyqWYIo+UKmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHHH/F8EXYJMsAai0VU+CJMTOUNXqZIau8RCzKJctcAEnyH8MyrsvvKNy7kbpNnSH
	 icwF4JZIw7Ll17LUc4B50WQQIawFqsr2ovJwN2+WtJgGNXGna3XJM2Dc6G/wOzotti
	 FU5FcEY4qVC0LfQzcx3NxIMx20LDMWvRGtLQvaTYt20QdcxkXBRYbDo+dNTY+u0XjG
	 v+x3FXaFps7m7UayW0HUucDDobSfC6ePU+0miVu7imnOeRPwLfSeRE0j2PSiqvwpgM
	 s65+0gqM4555/QinXnWeFQTWxDeoU9Cux2wXDgR5aTUkx0Ob9bftYM9fYStKAPKebO
	 LoKsqlyjI+Qfg==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] DAMON multiple contexts support
Date: Sun,  2 Jun 2024 08:56:12 -0700
Message-Id: <20240602155612.91435-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240602153102.926789-1-yorha.op@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  2 Jun 2024 18:31:02 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> Hi SJ,
> 
> > Hello Alex,
> > 
> > On Fri, 31 May 2024 15:23:18 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:
> > 
> > > Currently kdamond uses only one context per kthread
> > > and most of its time it sleeps, so utilizing several
> > > contexts can scale kdamond and allow it to use
> > > another set of operations.
> > > 
> > > This patch-set implements support for multiple contexts
> > > per kdamond.
> > >
> > [...]
> > > 
> > > ---
> > > Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
> > > - Compatibility for DebugFS interface is kept
> > > - Kunit tests build/execution issues are fixed
> > > - Patches from v1 are sqaushed, so that consistency between patches is
> > > kept
> > 
> > My request was to avoid unnecessary temporal changes that will be removed in
> > next patches.  Some of those are well removed in this version, but I still show
> > some.  E.g., nr_contexts field.  Also, this resulted in two big patches.
> 
> This makes sense and I actually wanted that as well, so I tried to separate
> them in previous version, looks like I misunderstood your request.

No problem, I think I should also be more clear about the point.  Happy to have
a chance to develop my humble communication skill with the conversaions with
you.

> 
> Anyway, don't you mind if lru_sort/traceevents/etc. will not function
> correctly without applying the whole patch-set? I mean if we use the
> approach below, once core.c is modified at least lru_sort and reclaim
> will not work correctly, they even will not be built.

I mind those.  Everything should work without regression in the middle of the
patchset.  Nonetheless, we should avoid only regression.  We don't need to make
everything perfect.  Let's minimize changes to the other modules in the way.

I believe below suggested patches flow and my second reply to the second patch
of this patchset can clarify the point.  Please let me know if not.

> 
> > 
> > I'd also appreciate if you can separate changes into smaller ones of logical
> > single change.  For example, changes for lru_sort.c, reclaim.c, and sysfs.c on
> > first patch could be much smaller in my opinion.  Traceevent change can also be
> > separated from patch 2.  Some of multi-context support seems mixed in patch 1.
> > 
> > I'd suggest below patches flow.
> > 
> > Patch 1: Introduce new struct and control functions for the struct.  Don't
> > really use the struct and the functions.
> > 
> > Patch 2: Modify core.c to use the struct and implement multiple contexts
> > support.  Minimize changes to core.c users.  Just keep those work as before.
> > Don't implement multi contexts support on sysfs.c or trace events at this
> > point.
> > 
> > Patch 3: Update sysfs.c to support the multiple contexts.
> > 
> > Patch 4: Update trace events to better support it.

As I mentioned on my second reply to the second patch, you could swich patches
3 and 4 if you want trace events to work perfect from the beginning of
user-visible multi contexts support.


Thanks,
SJ

[...]
