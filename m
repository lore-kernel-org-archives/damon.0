Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968846;
	b=Hmv9vG/v1XBSG9ZSRaqVS5NkICWiNXEdwEJcxjGUH/Fwb0yft3U9Qjlm6lNszn18MUdB
	 St5MIxn8YScRn+VKUMCICWSObDVRl53HLU1IvGiZwKt1jxp10CkQoxUB5HorBnhi/tyOE
	 CZ4yYY5TMllY2oeVJax52hIJBkWl8DJfNC3xDgXkT4d9oBP4bBRe4D6IYOS4NdgyfB9p7
	 iZSSxcGt2+EOB/HDG7FOQMoApSUt9Gwsz0b7YjyO68XmeWcXIwkMfGeAlEK9MRJg+DUZ3
	 rJNZmSQzL63tl6Ev3XvIiKuV52XsZkoxnYe/l576SfUL0elcgVL1EOKax+AZybsGokw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=px9vMN6ExAiQQxO21BTbDa+giJNPqVxeMQ6xFOzgn+4=;
	b=e2agY4N7kZN2vHJHmFgDfzWdlYgVEAkIDEVWE6y/RKYw2PGB5cAS9dHzQG2IkyAeFzac
	 VJZywoDQL0bPNIIdr5b/zqfP11G+68Eg3cfRSFZUWqSix+dSBr/c2wkN6fnmfOCbWtJNy
	 uPu8ldP5MpG07rWifzpggE1BdLjYj29jV3MPc8tT5f7F4PCYBgmrohfe65LYXxpHs7Cdb
	 PaeUCHNzo5dpVPLcpLgJz6F6Swzm8MM2WfappgWMR65wHHJ1qUOhBb8FbiWfVOkVCmNfB
	 MfTftvUc9To/+w7fZxrT74lGq8Mxie7Mu3ZJUXhZmanzPJRhxV7hbflNTGiVevnfp1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5mBDD1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F37606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5mBDD1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775BA1F000C4;
	Wed, 18 Nov 2026 02:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968845;
	bh=px9vMN6ExAiQQxO21BTbDa+giJNPqVxeMQ6xFOzgn+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5mBDD1tsWfBXaV2sz2dZzeVzx6NH5gHnYlZ0xJhvXqQoCODYsXF3DiyjD9aBh9ev
	 dHCr4I3B2+lPVd0ZfgI3yF/3mWwyCUBioukAeg4e4AY7KgIzHYDyh4xU/MRdDjWcQ1
	 q//IW3373l/N6l1Gx9q7Jfhx65p0sLUQKY+EEHu0q86lU4WqNh/bmZdKp4DwtljZ3S
	 OFFQ4RoveAWuUs8lZWa0xwgjMlKJtPyjmdEQ3n0nJdR7lWDDU5QXMwoj3JHQb2HfIR
	 FGnQWmly9Uvoi0hiyYzmUFO99ieXadUGd4A5RqSfoOLigHwbLb/hyvaUttTtBv9e6P
	 fQ/CG1fYI1Aaw==
Message-ID: <sashiko-outbox-219946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/27] Docs/admin-guide/mm/damon/usage: update
 for report producer sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-11-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added report producer control
> sysfs files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D10

