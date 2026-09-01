Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DE3955F1
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270097; cv=none; b=kilRRQXhTrdmI0Y0fRpPptdhFXIPGf9AkdbVGbMMsxF0OvGlwDRihFkECbTKN3P4zvvxLqB+IF1wRLzh4e52gb0Dzoxm7YoN5rEKbKBqiJWdxCGrHmOqiHOA4bjtJEYOa3KI0OUmL6+YQQDMUAuUhbjC8b/Iv5tJOTZaxDpQwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270097; c=relaxed/simple;
	bh=IUHgj9UexfMSPUUIERlHN7g4qjm0Z8L7zQkJFKmg+l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hO05Wt5QDchd8ePq3qTQYzbgdXIo/hly7sQ5HqQOp2rCn1pTbdlucUFBpPlzYJOnYwtmZBcN4HNB/rjUQoSusGzgCsQIg+7rCLVmG10GSGdy2YzR1+ZeEGk2//nkztuSspRPfdfkQHsrjlflXZAUF2oPsdwn5BeWQOFEQCYfi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emc8QaYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emc8QaYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0234E1F000E9;
	Tue,  1 Sep 2026 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270095;
	bh=yKm6Vc9DN8F/nM6cUnHsi8FAxsuxQFpyB8FLI7wXcW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emc8QaYHxPF+kXCRweOI1Gnu2F6naklyZSp7J/XJEARPZF3Y8QCguK2KNh4HVHC0n
	 ggVDAZVCfVVR72CgNrHXNwixMOS0zci+Y4lbBH8c49FPG6vg4sfK5V/uTy1SPMfidN
	 J7HQTIy8N1V+GJnyuYTuq7I/4nJglAcFzGQHJUDWTw5SDrQIkMYlPadH1VFij1jLu7
	 KM0EcZEjk8WoW3MwnomYYN4CioAzTKLn0VMfdOCVKeZhWV+YHWn9WamQnpWWR6JZ+H
	 b8QQK3NbgUM7gsA7GsKtRv5F5E1fzY0//sOfVFDBaveRxP44scffpQcZzfs5HvgKj/
	 UXq05IKHAt+Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 13/17] mm/damon/sysfs: pass preps to DAMON core
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-14-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:41:34 +0000
Message-Id: <20260901134135.0234E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface provides the files for setting DAMON probe preps.
> But the underlying code is not really passing the user-set values to
> DAMON core.  Pass those.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D13

